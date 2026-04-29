#if canImport(AppKit)
import AppKit
import ApplicationServices
import ChromeWheelRouterMac

@main
struct ChromeWheelRouterMain {
    private static let appDelegate = ChromeWheelRouterApp()

    static func main() {
        let app = NSApplication.shared
        app.setActivationPolicy(.accessory)
        app.delegate = appDelegate
        app.run()
    }
}

final class ChromeWheelRouterApp: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var statusMenu: NSMenu!

    private var enabledMenuItem: NSMenuItem!
    private var dryRunMenuItem: NSMenuItem!
    private var statusMenuItem: NSMenuItem!
    private var permissionMenuItem: NSMenuItem!

    private var userEnabled = false
    private var dryRunEnabled = false
    private var tapService: CGEventTapService?
    private var statusPollTimer: Timer?
    private var startupHeartbeatTimer: Timer?

    private lazy var appSupportDirectory: URL = {
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Library/Application Support", isDirectory: true)
        return base.appendingPathComponent("ChromeWheelRouter", isDirectory: true)
    }()

    private var killSwitchURL: URL {
        appSupportDirectory.appendingPathComponent("kill-switch", isDirectory: false)
    }

    private var logURL: URL {
        appSupportDirectory.appendingPathComponent("runtime.log", isDirectory: false)
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        ensureAppSupportDirectory()
        appendLog("Application launched. bundlePath=\(Bundle.main.bundlePath)")
        buildMenuBarUI()
        appendLog("Status item created.")
        startStatusPolling()
        startStartupHeartbeat()
        reconcileRuntime()
    }

    func applicationWillTerminate(_ notification: Notification) {
        statusPollTimer?.invalidate()
        statusPollTimer = nil
        startupHeartbeatTimer?.invalidate()
        startupHeartbeatTimer = nil
        stopTapService()
    }

    private func buildMenuBarUI() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.title = "CWR"
        statusItem.button?.toolTip = "ChromeWheelRouter"

        statusMenu = NSMenu()

        statusMenuItem = NSMenuItem(title: "Status: Starting...", action: nil, keyEquivalent: "")
        statusMenuItem.isEnabled = false
        statusMenu.addItem(statusMenuItem)

        permissionMenuItem = NSMenuItem(title: "Permissions: Checking...", action: nil, keyEquivalent: "")
        permissionMenuItem.isEnabled = false
        statusMenu.addItem(permissionMenuItem)

        statusMenu.addItem(.separator())

        enabledMenuItem = NSMenuItem(title: "Enable", action: #selector(toggleEnabled), keyEquivalent: "e")
        enabledMenuItem.target = self
        statusMenu.addItem(enabledMenuItem)

        dryRunMenuItem = NSMenuItem(title: "Dry Run", action: #selector(toggleDryRun), keyEquivalent: "d")
        dryRunMenuItem.target = self
        dryRunMenuItem.state = .off
        statusMenu.addItem(dryRunMenuItem)

        statusMenu.addItem(.separator())

        let openAccessibilityItem = NSMenuItem(title: "Open Accessibility Settings", action: #selector(openAccessibilitySettings), keyEquivalent: "a")
        openAccessibilityItem.target = self
        statusMenu.addItem(openAccessibilityItem)

        let openInputMonitoringItem = NSMenuItem(title: "Open Input Monitoring Settings", action: #selector(openInputMonitoringSettings), keyEquivalent: "i")
        openInputMonitoringItem.target = self
        statusMenu.addItem(openInputMonitoringItem)

        let checkPermissionsItem = NSMenuItem(title: "Check Permissions", action: #selector(checkPermissions), keyEquivalent: "k")
        checkPermissionsItem.target = self
        statusMenu.addItem(checkPermissionsItem)

        let requestPermissionPromptsItem = NSMenuItem(title: "Request Permission Prompts", action: #selector(requestPermissionPrompts), keyEquivalent: "p")
        requestPermissionPromptsItem.target = self
        statusMenu.addItem(requestPermissionPromptsItem)

        let openLogsItem = NSMenuItem(title: "Open Logs", action: #selector(openLogs), keyEquivalent: "l")
        openLogsItem.target = self
        statusMenu.addItem(openLogsItem)

        statusMenu.addItem(.separator())

        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        statusMenu.addItem(quitItem)

        statusMenu.delegate = self
        statusItem.menu = statusMenu
    }

    @objc
    private func toggleEnabled() {
        userEnabled.toggle()
        reconcileRuntime()
    }

    @objc
    private func toggleDryRun() {
        dryRunEnabled.toggle()
        reconcileRuntime()
    }

    @objc
    private func openAccessibilitySettings() {
        openPrivacySettingsPane(anchor: "Privacy_Accessibility")
    }

    @objc
    private func openInputMonitoringSettings() {
        openPrivacySettingsPane(anchor: "Privacy_ListenEvent")
    }

    @objc
    private func openLogs() {
        let consoleURL = URL(fileURLWithPath: "/System/Applications/Utilities/Console.app")
        NSWorkspace.shared.openApplication(at: consoleURL, configuration: NSWorkspace.OpenConfiguration()) { _, _ in }
    }

    @objc
    private func quitApp() {
        stopTapService()
        NSApp.terminate(nil)
    }


    @objc
    private func requestPermissionPrompts() {
        requestPermissions(forcePrompt: true)
        reconcileRuntime()
    }

    @objc
    private func checkPermissions() {
        let accessibilityGranted = AXIsProcessTrusted()
        let inputMonitoringGranted = CGPreflightListenEventAccess()
        let allGranted = accessibilityGranted && inputMonitoringGranted

        reconcileRuntime()
        appendLog(
            "Permission check: accessibility=\(accessibilityGranted) inputMonitoring=\(inputMonitoringGranted) allGranted=\(allGranted)."
        )
        showPermissionCheckResult(
            accessibilityGranted: accessibilityGranted,
            inputMonitoringGranted: inputMonitoringGranted,
            allGranted: allGranted
        )
    }

    private func requestPermissions(forcePrompt: Bool) {
        let accessibilityPromptOptions = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: forcePrompt] as CFDictionary
        _ = AXIsProcessTrustedWithOptions(accessibilityPromptOptions)
        _ = CGRequestListenEventAccess()
        appendLog("Requested Accessibility/Input Monitoring permission prompts.")
    }

    private func startStatusPolling() {
        statusPollTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.reconcileRuntime()
        }
    }

    private func showPermissionCheckResult(
        accessibilityGranted: Bool,
        inputMonitoringGranted: Bool,
        allGranted: Bool
    ) {
        let alert = NSAlert()
        alert.messageText = allGranted ? "Permissions Granted" : "Permissions Missing"
        alert.informativeText = """
        Accessibility: \(accessibilityGranted ? "Granted" : "Missing")
        Input Monitoring: \(inputMonitoringGranted ? "Granted" : "Missing")

        \(allGranted ? "ChromeWheelRouter has the permissions needed to run its scroll routing functionality." : "ChromeWheelRouter will stay disabled until both permissions are granted.")
        """
        alert.alertStyle = allGranted ? .informational : .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }

    private func startStartupHeartbeat() {
        startupHeartbeatTimer?.invalidate()
        startupHeartbeatTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            guard let self else {
                return
            }
            self.appendLog("Application still running. permissionsSatisfied=\(self.permissionsSatisfied())")
        }
    }

    private func openPrivacySettingsPane(anchor: String) {
        guard let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?") else {
            return
        }
        let fullURL = URL(string: "\(url.absoluteString)\(anchor)")
        if let fullURL {
            NSWorkspace.shared.open(fullURL)
        }
    }

    private func permissionsSatisfied() -> Bool {
        AXIsProcessTrusted() && CGPreflightListenEventAccess()
    }

    private func reconcileRuntime() {
        if killSwitchPresent() {
            if userEnabled {
                appendLog("Kill switch present. Forcing disabled state.")
            }
            userEnabled = false
        }

        let hasPermissions = permissionsSatisfied()
        let shouldRun = userEnabled && hasPermissions

        if shouldRun {
            let mode: EventTapMode = dryRunEnabled ? .dryRun : .active
            restartTapService(mode: mode)
        } else {
            stopTapService()
        }

        refreshMenuState(hasPermissions: hasPermissions, running: shouldRun)
    }

    private func restartTapService(mode: EventTapMode) {
        stopTapService()
        let service = CGEventTapService(
            mode: mode,
            isEnabled: { [weak self] in self?.userEnabled == true },
            onTapDisabled: { [weak self] reason in
                self?.appendLog("Event tap temporarily disabled: \(reason).")
            },
            logger: { [weak self] line in
                self?.appendLog(line)
            }
        )
        if service.start() {
            tapService = service
            appendLog("Event tap started in mode=\(mode.rawValue).")
        } else {
            tapService = nil
            userEnabled = false
            appendLog("Failed to start event tap. Disabling app.")
        }
    }

    private func stopTapService() {
        tapService?.stop()
        if tapService != nil {
            appendLog("Event tap stopped.")
        }
        tapService = nil
    }

    private func refreshMenuState(hasPermissions: Bool, running: Bool) {
        enabledMenuItem.state = userEnabled ? .on : .off
        enabledMenuItem.title = userEnabled ? "Disable" : "Enable"
        dryRunMenuItem.state = dryRunEnabled ? .on : .off

        permissionMenuItem.title = hasPermissions ? "Permissions: Granted" : "Permissions: Missing"

        if running {
            statusMenuItem.title = dryRunEnabled ? "Status: Running (Dry Run)" : "Status: Running"
        } else if !hasPermissions {
            statusMenuItem.title = "Status: Missing Permissions"
        } else {
            statusMenuItem.title = "Status: Disabled"
        }
    }

    private func killSwitchPresent() -> Bool {
        FileManager.default.fileExists(atPath: killSwitchURL.path)
    }

    private func ensureAppSupportDirectory() {
        do {
            try FileManager.default.createDirectory(at: appSupportDirectory, withIntermediateDirectories: true)
        } catch {
            fputs("Failed to create app support directory: \(error)\n", stderr)
        }
    }

    private func appendLog(_ line: String) {
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let entry = "[\(timestamp)] \(line)\n"
        guard let data = entry.data(using: .utf8) else {
            return
        }

        if !FileManager.default.fileExists(atPath: logURL.path) {
            FileManager.default.createFile(atPath: logURL.path, contents: data)
            return
        }

        do {
            let handle = try FileHandle(forWritingTo: logURL)
            defer { try? handle.close() }
            try handle.seekToEnd()
            try handle.write(contentsOf: data)
        } catch {
            fputs("Failed to append runtime log: \(error)\n", stderr)
        }
    }
}

extension ChromeWheelRouterApp: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        appendLog("Status menu will open.")
        reconcileRuntime()
    }
}
#else
import Foundation

@main
struct ChromeWheelRouterApp {
    static func main() {
        fputs("ChromeWheelRouterApp is only supported on macOS.\n", stderr)
        Foundation.exit(1)
    }
}
#endif
