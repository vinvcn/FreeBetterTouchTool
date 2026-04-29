#if canImport(AppKit)
import AppKit
import CoreGraphics
import ChromeWheelRouterCore

public final class CGEventTapService {
    private let router: Router
    private let mode: EventTapMode
    private let isEnabled: () -> Bool
    private var eventTap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?

    public init(
        router: Router = Router(),
        mode: EventTapMode,
        isEnabled: @escaping () -> Bool = { true }
    ) {
        self.router = router
        self.mode = mode
        self.isEnabled = isEnabled
    }

    public func start() -> Bool {
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

    public func run() {
        CFRunLoopRun()
    }

    private func handleEvent(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent) -> Unmanaged<CGEvent>? {
        if type == .tapDisabledByTimeout || type == .tapDisabledByUserInput {
            if let tap = eventTap {
                CGEvent.tapEnable(tap: tap, enable: true)
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

        log(decision: decision, model: model)

        // EXEC-03 safety invariant: return original event in all modes.
        return Unmanaged.passUnretained(event)
    }

    private func log(decision: RouteDecision, model: ScrollEventModel) {
        switch mode {
        case .listenOnly:
            print("mode=listen-only observed app=\(model.frontmostBundleID) dx=\(model.horizontalDelta) dy=\(model.verticalDelta) modifiers=\(model.modifiers) decision=\(decision)")
        case .dryRun:
            print("mode=dry-run classified app=\(model.frontmostBundleID) dx=\(model.horizontalDelta) dy=\(model.verticalDelta) decision=\(decision) action=pass-through")
        case .active:
            print("mode=active classified app=\(model.frontmostBundleID) dx=\(model.horizontalDelta) dy=\(model.verticalDelta) decision=\(decision) action=pass-through-exec-03")
        }
    }
}
#else
import ChromeWheelRouterCore

public final class CGEventTapService {
    public init(router: Router = Router(), mode: EventTapMode, isEnabled: @escaping () -> Bool = { true }) {}

    public func start() -> Bool {
        false
    }

    public func run() {}
}
#endif
