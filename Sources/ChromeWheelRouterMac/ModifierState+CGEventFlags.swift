#if canImport(CoreGraphics)
import CoreGraphics
import ChromeWheelRouterCore

public extension ModifierState {
    init(flags: CGEventFlags) {
        var state: ModifierState = []

        if flags.contains(.maskAlternate) {
            state.insert(.option)
        }
        if flags.contains(.maskCommand) {
            state.insert(.command)
        }
        if flags.contains(.maskShift) {
            state.insert(.shift)
        }
        if flags.contains(.maskControl) {
            state.insert(.control)
        }

        self = state
    }
}
#endif
