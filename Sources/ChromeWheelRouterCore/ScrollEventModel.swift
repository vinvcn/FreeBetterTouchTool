public struct ScrollEventModel: Sendable, Equatable {
    public let frontmostBundleID: String
    public let horizontalDelta: Int64
    public let verticalDelta: Int64
    public let modifiers: ModifierState
    public let routerEnabled: Bool

    public init(
        frontmostBundleID: String,
        horizontalDelta: Int64,
        verticalDelta: Int64,
        modifiers: ModifierState,
        routerEnabled: Bool = true
    ) {
        self.frontmostBundleID = frontmostBundleID
        self.horizontalDelta = horizontalDelta
        self.verticalDelta = verticalDelta
        self.modifiers = modifiers
        self.routerEnabled = routerEnabled
    }
}
