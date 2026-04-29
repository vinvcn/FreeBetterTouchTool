public enum RouteDecision: Sendable, Equatable {
    case passThrough
    case zoomInAndSwallow
    case zoomOutAndSwallow
}
