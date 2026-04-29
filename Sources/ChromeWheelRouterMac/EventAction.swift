import ChromeWheelRouterCore

public enum EventAction: String, Sendable, Equatable {
    case passThrough
    case injectAndSwallow

    static func forMode(_ mode: EventTapMode, decision: RouteDecision) -> EventAction {
        guard mode == .active else {
            return .passThrough
        }

        switch decision {
        case .zoomInAndSwallow, .zoomOutAndSwallow:
            return .injectAndSwallow
        case .passThrough:
            return .passThrough
        }
    }
}
