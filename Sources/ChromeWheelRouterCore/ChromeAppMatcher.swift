public struct ChromeAppMatcher: Sendable {
    public let chromeBundleIDs: Set<String>

    public init(chromeBundleIDs: Set<String> = ChromeAppMatcher.defaultChromeBundleIDs) {
        self.chromeBundleIDs = chromeBundleIDs
    }

    public static let defaultChromeBundleIDs: Set<String> = [
        "com.google.Chrome",
        "com.google.Chrome.beta",
        "com.google.Chrome.canary",
        "com.google.Chrome.dev"
    ]

    public func isChrome(bundleID: String) -> Bool {
        chromeBundleIDs.contains(bundleID)
    }
}
