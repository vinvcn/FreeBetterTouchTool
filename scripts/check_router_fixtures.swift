import Foundation

struct FixtureFile: Decodable {
    let version: Int
    let scenarios: [Scenario]
}

struct Scenario: Decodable {
    let id: String
    let name: String
    let input: FixtureInput
    let expectedDecision: String
}

struct FixtureInput: Decodable {
    let frontmostBundleID: String
    let horizontalDelta: Int64
    let verticalDelta: Int64
    let modifiers: [String]
    let routerEnabled: Bool
}

@main
struct RouterFixtureRunner {
    static func main() {
        let path = CommandLine.arguments.dropFirst().first ?? "ChromeWheelRouter/docs/qa/router_decision_fixtures/scenarios.json"
        let url = URL(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: url)
            let fixtures = try JSONDecoder().decode(FixtureFile.self, from: data)
            try run(fixtures)
        } catch {
            fputs("router fixture check failed: \(error)\n", stderr)
            exit(1)
        }
    }

    private static func run(_ fixtures: FixtureFile) throws {
        guard fixtures.version == 1 else {
            throw FixtureError.unsupportedVersion(fixtures.version)
        }
        guard !fixtures.scenarios.isEmpty else {
            throw FixtureError.emptyScenarios
        }

        let router = Router()
        var seenIDs = Set<String>()
        var failures: [String] = []

        for scenario in fixtures.scenarios {
            guard seenIDs.insert(scenario.id).inserted else {
                throw FixtureError.duplicateID(scenario.id)
            }

            let expected = try decision(named: scenario.expectedDecision)
            let event = try event(from: scenario.input)
            let actual = router.decide(event)
            if actual != expected {
                failures.append("\(scenario.id) \(scenario.name): expected \(name(for: expected)), got \(name(for: actual))")
            }
        }

        if !failures.isEmpty {
            fputs("router fixture mismatches:\n", stderr)
            for failure in failures {
                fputs("- \(failure)\n", stderr)
            }
            exit(1)
        }

        print("router fixtures: OK (\(fixtures.scenarios.count) scenarios)")
    }

    private static func event(from input: FixtureInput) throws -> ScrollEventModel {
        ScrollEventModel(
            frontmostBundleID: input.frontmostBundleID,
            horizontalDelta: input.horizontalDelta,
            verticalDelta: input.verticalDelta,
            modifiers: try modifiers(named: input.modifiers),
            routerEnabled: input.routerEnabled
        )
    }

    private static func modifiers(named names: [String]) throws -> ModifierState {
        var state: ModifierState = []
        for name in names {
            switch name {
            case "command":
                state.insert(.command)
            case "option":
                state.insert(.option)
            case "control":
                state.insert(.control)
            case "shift":
                state.insert(.shift)
            default:
                throw FixtureError.unknownModifier(name)
            }
        }
        return state
    }

    private static func decision(named name: String) throws -> RouteDecision {
        switch name {
        case "passThrough":
            return .passThrough
        case "zoomInAndSwallow":
            return .zoomInAndSwallow
        case "zoomOutAndSwallow":
            return .zoomOutAndSwallow
        case "nextTabAndSwallow":
            return .nextTabAndSwallow
        case "previousTabAndSwallow":
            return .previousTabAndSwallow
        default:
            throw FixtureError.unknownDecision(name)
        }
    }

    private static func name(for decision: RouteDecision) -> String {
        switch decision {
        case .passThrough:
            return "passThrough"
        case .zoomInAndSwallow:
            return "zoomInAndSwallow"
        case .zoomOutAndSwallow:
            return "zoomOutAndSwallow"
        case .nextTabAndSwallow:
            return "nextTabAndSwallow"
        case .previousTabAndSwallow:
            return "previousTabAndSwallow"
        }
    }
}

enum FixtureError: Error, CustomStringConvertible {
    case duplicateID(String)
    case emptyScenarios
    case unknownDecision(String)
    case unknownModifier(String)
    case unsupportedVersion(Int)

    var description: String {
        switch self {
        case .duplicateID(let id):
            return "duplicate scenario id: \(id)"
        case .emptyScenarios:
            return "scenarios.json must contain at least one scenario"
        case .unknownDecision(let name):
            return "unknown expectedDecision: \(name)"
        case .unknownModifier(let name):
            return "unknown modifier: \(name)"
        case .unsupportedVersion(let version):
            return "unsupported fixture version: \(version)"
        }
    }
}
