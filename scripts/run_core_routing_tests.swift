import Foundation

@main
struct CoreRoutingTestRunner {
    static func main() {
        let router = Router()
        var failures: [String] = []

        func check(_ name: String, _ event: ScrollEventModel, _ expected: RouteDecision) {
            let actual = router.decide(event)
            if actual != expected {
                failures.append("\(name): expected \(expected), got \(actual)")
            }
        }

        check("non-Chrome Option horizontal passes through", ScrollEventModel(frontmostBundleID: "com.apple.finder", horizontalDelta: 1, verticalDelta: 0, modifiers: [.option]), .passThrough)
        check("Chrome vertical-only passes through", ScrollEventModel(frontmostBundleID: "com.google.Chrome", horizontalDelta: 0, verticalDelta: 1, modifiers: [.option]), .passThrough)
        check("Chrome bare horizontal passes through for Logi Options+", ScrollEventModel(frontmostBundleID: "com.google.Chrome", horizontalDelta: 1, verticalDelta: 0, modifiers: []), .passThrough)
        check("Chrome Command horizontal passes through", ScrollEventModel(frontmostBundleID: "com.google.Chrome", horizontalDelta: 1, verticalDelta: 0, modifiers: [.command]), .passThrough)
        check("Chrome Shift horizontal passes through", ScrollEventModel(frontmostBundleID: "com.google.Chrome", horizontalDelta: 1, verticalDelta: 0, modifiers: [.shift]), .passThrough)
        check("Chrome Control horizontal passes through", ScrollEventModel(frontmostBundleID: "com.google.Chrome", horizontalDelta: 1, verticalDelta: 0, modifiers: [.control]), .passThrough)
        check("Chrome Option+Command horizontal passes through", ScrollEventModel(frontmostBundleID: "com.google.Chrome", horizontalDelta: 1, verticalDelta: 0, modifiers: [.option, .command]), .passThrough)
        check("Chrome Option horizontal positive delta zooms in and swallows", ScrollEventModel(frontmostBundleID: "com.google.Chrome", horizontalDelta: 1, verticalDelta: 0, modifiers: [.option]), .zoomInAndSwallow)
        check("Chrome Option horizontal negative delta zooms out and swallows", ScrollEventModel(frontmostBundleID: "com.google.Chrome", horizontalDelta: -1, verticalDelta: 0, modifiers: [.option]), .zoomOutAndSwallow)
        check("disabled router always passes through", ScrollEventModel(frontmostBundleID: "com.google.Chrome", horizontalDelta: 1, verticalDelta: 0, modifiers: [.option], routerEnabled: false), .passThrough)

        if !failures.isEmpty {
            fputs("core routing tests failed:\n", stderr)
            for failure in failures {
                fputs("- \(failure)\n", stderr)
            }
            exit(1)
        }

        print("core routing tests: OK")
    }
}
