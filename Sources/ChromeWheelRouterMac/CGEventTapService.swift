#if canImport(AppKit)
import AppKit
import CoreGraphics
import ChromeWheelRouterCore

public enum EventTapDisableReason: Sendable {
    case timeout
    case userInput
}

public final class CGEventTapService {
    private let router: Router
    private let mode: EventTapMode
    private let isEnabled: () -> Bool
    private let keyboardInjector: KeyboardInjecting
    private let onTapDisabled: ((EventTapDisableReason) -> Void)?
    private let logger: (String) -> Void
    private var eventTap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?

    public init(
        router: Router = Router(),
        mode: EventTapMode,
        isEnabled: @escaping () -> Bool = { true },
        keyboardInjector: KeyboardInjecting = CGKeyboardInjector(),
        onTapDisabled: ((EventTapDisableReason) -> Void)? = nil,
        logger: @escaping (String) -> Void = { print($0) }
    ) {
        self.router = router
        self.mode = mode
        self.isEnabled = isEnabled
        self.keyboardInjector = keyboardInjector
        self.onTapDisabled = onTapDisabled
        self.logger = logger
    }

    public func start() -> Bool {
        guard eventTap == nil else {
            return true
        }

        let mask = CGEventMask(1 << CGEventType.scrollWheel.rawValue)
        let callback: CGEventTapCallBack = { proxy, type, event, context in
            guard let context else { return Unmanaged.passUnretained(event) }
            let service = Unmanaged<CGEventTapService>.fromOpaque(context).takeUnretainedValue()
            return service.handleEvent(proxy: proxy, type: type, event: event)
        }

        guard let tap = CGEvent.tapCreate(
            tap: .cgSessionEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: mask,
            callback: callback,
            userInfo: UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        ) else {
            return false
        }

        eventTap = tap
        let source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
        runLoopSource = source
        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, .commonModes)
        CGEvent.tapEnable(tap: tap, enable: true)
        return true
    }

    public func stop() {
        guard let tap = eventTap else {
            return
        }

        CGEvent.tapEnable(tap: tap, enable: false)
        if let source = runLoopSource {
            CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, .commonModes)
        }
        runLoopSource = nil
        eventTap = nil
    }

    public func run() {
        CFRunLoopRun()
    }

    private func handleEvent(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent) -> Unmanaged<CGEvent>? {
        if type == .tapDisabledByTimeout || type == .tapDisabledByUserInput {
            if isEnabled(), let tap = eventTap {
                CGEvent.tapEnable(tap: tap, enable: true)
            }

            if type == .tapDisabledByTimeout {
                onTapDisabled?(.timeout)
            } else {
                onTapDisabled?(.userInput)
            }
            return Unmanaged.passUnretained(event)
        }

        guard type == .scrollWheel else {
            return Unmanaged.passUnretained(event)
        }

        let frontmostBundleID = NSWorkspace.shared.frontmostApplication?.bundleIdentifier ?? "unknown"
        let model = ScrollEventAdapter.makeModel(
            event: event,
            frontmostBundleID: frontmostBundleID,
            routerEnabled: isEnabled()
        )
        let decision = router.decide(model)
        let action = EventAction.forMode(mode, decision: decision)

        log(decision: decision, model: model, action: action)

        guard action == .injectAndSwallow else {
            return Unmanaged.passUnretained(event)
        }

        let injected: Bool
        switch decision {
        case .zoomInAndSwallow:
            injected = keyboardInjector.sendChromeZoomIn()
        case .zoomOutAndSwallow:
            injected = keyboardInjector.sendChromeZoomOut()
        case .passThrough:
            injected = false
        }

        return injected ? nil : Unmanaged.passUnretained(event)
    }

    private func log(decision: RouteDecision, model: ScrollEventModel, action: EventAction) {
        logger("mode=\(mode.rawValue) app=\(model.frontmostBundleID) dx=\(model.horizontalDelta) dy=\(model.verticalDelta) decision=\(decision) action=\(action)")
    }
}
#else
import ChromeWheelRouterCore

public enum EventTapDisableReason: Sendable {
    case timeout
    case userInput
}

public final class CGEventTapService {
    public init(
        router: Router = Router(),
        mode: EventTapMode,
        isEnabled: @escaping () -> Bool = { true },
        keyboardInjector: KeyboardInjecting = CGKeyboardInjector(),
        onTapDisabled: ((EventTapDisableReason) -> Void)? = nil,
        logger: @escaping (String) -> Void = { _ in }
    ) {}

    public func start() -> Bool {
        false
    }

    public func stop() {}

    public func run() {}
}
#endif
