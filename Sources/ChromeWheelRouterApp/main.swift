#if canImport(AppKit)
import AppKit
import ApplicationServices
import ChromeWheelRouterMac

@main
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

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        buildMenuBarUI()
        reconcileRuntime()
    }

    func applicationWillTerminate(_ notification: Notification) {
        stopTapService()
    }

    private func buildMenuBarUI() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.title = "CWR"

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

        let openLogsItem = NSMenuItem(title: "Open Logs", action: #selector(openLogs), keyEquivalent: "l")
        openLogsItem.target = self
        statusMenu.addItem(openLogsItem)

        statusMenu.addItem(.separator())

        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        statusMenu.addItem(quitItem)

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
        let service = CGEventTapService(mode: mode)
        if service.start() {
            tapService = service
        } else {
            tapService = nil
            userEnabled = false
        }
    }

    private func stopTapService() {
        tapService?.stop()
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
