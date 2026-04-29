import Foundation
import ChromeWheelRouterCore
import ChromeWheelRouterMac


struct CLI {
    static func run(arguments: [String]) throws {
        let mode = try parseMode(arguments: arguments)
        let service = CGEventTapService(mode: mode)

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
