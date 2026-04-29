import XCTest
@testable import ChromeWheelRouterCore
@testable import ChromeWheelRouterMac

final class EventActionTests: XCTestCase {
    func testListenOnlyNeverInjectsOrSwallows() {
        XCTAssertEqual(EventAction.forMode(.listenOnly, decision: .zoomInAndSwallow), .passThrough)
        XCTAssertEqual(EventAction.forMode(.listenOnly, decision: .zoomOutAndSwallow), .passThrough)
    }

    func testDryRunNeverInjectsOrSwallows() {
        XCTAssertEqual(EventAction.forMode(.dryRun, decision: .zoomInAndSwallow), .passThrough)
        XCTAssertEqual(EventAction.forMode(.dryRun, decision: .zoomOutAndSwallow), .passThrough)
    }

    func testActiveInjectsAndSwallowsOnlyMatchingDecisions() {
        XCTAssertEqual(EventAction.forMode(.active, decision: .zoomInAndSwallow), .injectAndSwallow)
        XCTAssertEqual(EventAction.forMode(.active, decision: .zoomOutAndSwallow), .injectAndSwallow)
        XCTAssertEqual(EventAction.forMode(.active, decision: .passThrough), .passThrough)
    }
}
