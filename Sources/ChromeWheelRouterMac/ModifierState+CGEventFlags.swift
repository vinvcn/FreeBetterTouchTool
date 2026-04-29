#if canImport(CoreGraphics)
import CoreGraphics
import ChromeWheelRouterCore

public extension ModifierState {
    init(flags: CGEventFlags) {
        self.init(
            option: flags.contains(.maskAlternate),
            command: flags.contains(.maskCommand),
            shift: flags.contains(.maskShift),
            control: flags.contains(.maskControl)
        )
    }
}
#endif
