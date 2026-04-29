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

        statusMenu.addItem(.separator())

        enabledMenuItem = NSMenuItem(title: "Enable", action: #selector(toggleEnabled), keyEquivalent: "e")
        enabledMenuItem.target = self
        statusMenu.addItem(enabledMenuItem)

        dryRunMenuItem = NSMenuItem(title: "Dry Run", action: #selector(toggleDryRun), keyEquivalent: "d")
        dryRunMenuItem.target = self
        dryRunMenuItem.state = .off
        statusMenu.addItem(dryRunMenuItem)

        statusMenu.addItem(.separator())

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
    private func openLogs() {
        let consoleURL = URL(fileURLWithPath: "/System/Applications/Utilities/Console.app")
        NSWorkspace.shared.openApplication(at: consoleURL, configuration: NSWorkspace.OpenConfiguration()) { _, _ in }
    }

    @objc
    private func quitApp() {
        stopTapService()
        NSApp.terminate(nil)
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

        if running {
            statusMenuItem.title = dryRunEnabled ? "Status: Running (Dry Run)" : "Status: Running"
        } else if !hasPermissions {
            statusMenuItem.title = "Status: Missing Accessibility/Input Monitoring"
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
