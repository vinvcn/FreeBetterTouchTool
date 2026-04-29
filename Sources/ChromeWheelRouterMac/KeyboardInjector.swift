#if canImport(AppKit)
import AppKit
import CoreGraphics

public protocol KeyboardInjecting: Sendable {
    func sendChromeZoomIn() -> Bool
    func sendChromeZoomOut() -> Bool
}

public struct CGKeyboardInjector: KeyboardInjecting {
    public init() {}

    public func sendChromeZoomIn() -> Bool {
        sendCommandShortcut(keyCode: 24)
    }

    public func sendChromeZoomOut() -> Bool {
        sendCommandShortcut(keyCode: 27)
    }

    private func sendCommandShortcut(keyCode: CGKeyCode) -> Bool {
        guard
            let source = CGEventSource(stateID: .combinedSessionState),
            let keyPress = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: true),
            let keyRelease = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: false)
        else {
            return false
        }

        keyPress.flags = .maskCommand
        keyRelease.flags = .maskCommand
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
}

public struct CGKeyboardInjector: KeyboardInjecting {
    public init() {}

    public func sendChromeZoomIn() -> Bool { false }

    public func sendChromeZoomOut() -> Bool { false }
}
#endif
