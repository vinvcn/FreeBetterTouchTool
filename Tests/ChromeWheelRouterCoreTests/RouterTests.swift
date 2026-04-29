import XCTest
@testable import ChromeWheelRouterCore

final class RouterTests: XCTestCase {
    private let router = Router()

    func testNonChromeOptionHorizontalPassesThrough() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.apple.finder",
            horizontalDelta: 1,
            verticalDelta: 0,
            modifiers: [.option]
        )

        XCTAssertEqual(router.decide(event), .passThrough)
    }

    func testChromeVerticalOnlyPassesThrough() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 0,
            verticalDelta: 1,
            modifiers: [.option]
        )

        XCTAssertEqual(router.decide(event), .passThrough)
    }

    func testChromeHorizontalAndVerticalSimultaneousPassesThrough() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 1,
            verticalDelta: 1,
            modifiers: [.option]
        )

        XCTAssertEqual(router.decide(event), .passThrough)
    }

    func testChromeHorizontalNoModifierPassesThrough() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 1,
            verticalDelta: 0,
            modifiers: []
        )

        XCTAssertEqual(router.decide(event), .passThrough)
    }

    func testChromeHorizontalCommandPassesThrough() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 1,
            verticalDelta: 0,
            modifiers: [.command]
        )

        XCTAssertEqual(router.decide(event), .passThrough)
    }

    func testChromeHorizontalShiftPassesThrough() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 1,
            verticalDelta: 0,
            modifiers: [.shift]
        )

        XCTAssertEqual(router.decide(event), .passThrough)
    }

    func testChromeHorizontalControlPositiveDeltaSwitchesToNextTabAndSwallows() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 1,
            verticalDelta: 0,
            modifiers: [.control]
        )

        XCTAssertEqual(router.decide(event), .nextTabAndSwallow)
    }

    func testChromeHorizontalControlNegativeDeltaSwitchesToPreviousTabAndSwallows() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: -1,
            verticalDelta: 0,
            modifiers: [.control]
        )

        XCTAssertEqual(router.decide(event), .previousTabAndSwallow)
    }

    func testChromeHorizontalOptionCommandPassesThrough() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 1,
            verticalDelta: 0,
            modifiers: [.option, .command]
        )

        XCTAssertEqual(router.decide(event), .passThrough)
    }

    func testChromeHorizontalControlOptionPassesThrough() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 1,
            verticalDelta: 0,
            modifiers: [.control, .option]
        )

        XCTAssertEqual(router.decide(event), .passThrough)
    }

    func testChromeHorizontalOptionPositiveDeltaZoomsInAndSwallows() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 1,
            verticalDelta: 0,
            modifiers: [.option]
        )

        XCTAssertEqual(router.decide(event), .zoomInAndSwallow)
    }

    func testChromeHorizontalOptionNegativeDeltaZoomsOutAndSwallows() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: -1,
            verticalDelta: 0,
            modifiers: [.option]
        )

        XCTAssertEqual(router.decide(event), .zoomOutAndSwallow)
    }

    func testDisabledRouterAlwaysPassesThrough() {
        let event = ScrollEventModel(
            frontmostBundleID: "com.google.Chrome",
            horizontalDelta: 1,
            verticalDelta: 0,
            modifiers: [.control],
            routerEnabled: false
        )

        XCTAssertEqual(router.decide(event), .passThrough)
    }
}
