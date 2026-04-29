public struct Router: Sendable {
    public let appMatcher: ChromeAppMatcher

    public init(appMatcher: ChromeAppMatcher = ChromeAppMatcher()) {
        self.appMatcher = appMatcher
    }

    public func decide(_ event: ScrollEventModel) -> RouteDecision {
        guard event.routerEnabled else {
            return .passThrough
        }

        guard appMatcher.isChrome(bundleID: event.frontmostBundleID) else {
            return .passThrough
        }

        guard event.isHorizontalOnlyScroll else {
            return .passThrough
        }

        guard event.modifiers.isOptionOnly else {
            return .passThrough
        }

        return event.horizontalDelta > 0 ? .zoomInAndSwallow : .zoomOutAndSwallow
    }
}
