#if canImport(CoreGraphics)
import CoreGraphics
import ChromeWheelRouterCore

public enum ScrollEventAdapter {
    public static func makeModel(
        event: CGEvent,
        frontmostBundleID: String,
        routerEnabled: Bool
    ) -> ScrollEventModel {
        let horizontalDelta = Int64(event.getIntegerValueField(.scrollWheelEventDeltaAxis2))
        let verticalDelta = Int64(event.getIntegerValueField(.scrollWheelEventDeltaAxis1))
        let modifiers = ModifierState(flags: event.flags)

        return ScrollEventModel(
            frontmostBundleID: frontmostBundleID,
            horizontalDelta: horizontalDelta,
            verticalDelta: verticalDelta,
            modifiers: modifiers,
            routerEnabled: routerEnabled
        )
    }
}
#endif
