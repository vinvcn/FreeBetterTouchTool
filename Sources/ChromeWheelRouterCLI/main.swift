import AppKit
import Foundation
import ChromeWheelRouterMac

final class FrontmostApplicationCache {
    private var cachedBundleID: String
    private var observer: NSObjectProtocol?

    init() {
        cachedBundleID = NSWorkspace.shared.frontmostApplication?.bundleIdentifier ?? "unknown"
        observer = NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didActivateApplicationNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            guard
                let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
                let bundleIdentifier = app.bundleIdentifier
            else {
                self?.cachedBundleID = "unknown"
                return
            }
            self?.cachedBundleID = bundleIdentifier
        }
    }

    deinit {
        if let observer {
            NSWorkspace.shared.notificationCenter.removeObserver(observer)
        }
    }

    func currentBundleID() -> String {
        cachedBundleID
    }
}

struct CLI {
    static func run(arguments: [String]) throws {
        let mode = try parseMode(arguments: arguments)
        let frontmostApplicationCache = FrontmostApplicationCache()
        let service = CGEventTapService(
            mode: mode,
            frontmostBundleID: { frontmostApplicationCache.currentBundleID() }
        )

        guard service.start() else {
            fputs("Failed to create scrollWheel-only event tap. Check macOS privacy permissions.\n", stderr)
            Foundation.exit(1)
        }

        print("ChromeWheelRouterCLI started in --\(mode.rawValue) mode. Press Ctrl+C to stop.")
        service.run()
    }

    private static func parseMode(arguments: [String]) throws -> EventTapMode {
        let modes = arguments.filter { $0.hasPrefix("--") }
        guard modes.count == 1 else {
            printUsageAndExit()
        }

        switch modes[0] {
        case "--listen-only":
            return .listenOnly
        case "--dry-run":
            return .dryRun
        case "--active":
            return .active
        default:
            printUsageAndExit()
        }
    }

    private static func printUsageAndExit() -> Never {
        let usage = """
        Usage: ChromeWheelRouterCLI [--listen-only|--dry-run|--active]

        --listen-only Observe and log scroll classification only.
        --dry-run     Classify matches but never swallow.
        --active      Reserved for EXEC-04 behavior; EXEC-03 still passes through.
        """
        print(usage)
        Foundation.exit(2)
    }
}

try CLI.run(arguments: CommandLine.arguments.dropFirst().map { $0 })
