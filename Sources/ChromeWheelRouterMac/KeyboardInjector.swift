#if canImport(AppKit)
import AppKit
import CoreGraphics

public protocol KeyboardInjecting: Sendable {
    func sendChromeZoomIn() -> Bool
    func sendChromeZoomOut() -> Bool
    func sendChromeNextTab() -> Bool
    func sendChromePreviousTab() -> Bool
}

public struct CGKeyboardInjector: KeyboardInjecting {
    public init() {}

    public func sendChromeZoomIn() -> Bool {
        sendCommandShortcut(keyCode: 24)
    }

    public func sendChromeZoomOut() -> Bool {
        sendCommandShortcut(keyCode: 27)
    }

    public func sendChromeNextTab() -> Bool {
        sendShortcut(keyCode: 48, flags: .maskControl)
    }

    public func sendChromePreviousTab() -> Bool {
        sendShortcut(keyCode: 48, flags: [.maskControl, .maskShift])
    }

    private func sendCommandShortcut(keyCode: CGKeyCode) -> Bool {
        sendShortcut(keyCode: keyCode, flags: .maskCommand)
    }

    private func sendShortcut(keyCode: CGKeyCode, flags: CGEventFlags) -> Bool {
        guard
            let source = CGEventSource(stateID: .combinedSessionState),
            let keyPress = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: true),
            let keyRelease = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: false)
        else {
            return false
        }

        keyPress.flags = flags
        keyRelease.flags = flags
        keyPress.post(tap: .cghidEventTap)
        keyRelease.post(tap: .cghidEventTap)
        return true
    }
}
#else
import Foundation

public protocol KeyboardInjecting: Sendable {
    func sendChromeZoomIn() -> Bool
    func sendChromeZoomOut() -> Bool
    func sendChromeNextTab() -> Bool
    func sendChromePreviousTab() -> Bool
}

public struct CGKeyboardInjector: KeyboardInjecting {
    public init() {}

    public func sendChromeZoomIn() -> Bool { false }

    public func sendChromeZoomOut() -> Bool { false }

    public func sendChromeNextTab() -> Bool { false }

    public func sendChromePreviousTab() -> Bool { false }
}
#endif
