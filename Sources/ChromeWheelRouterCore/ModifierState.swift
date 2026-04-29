public struct ModifierState: OptionSet, Sendable, Equatable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let command = ModifierState(rawValue: 1 << 0)
    public static let option  = ModifierState(rawValue: 1 << 1)
    public static let control = ModifierState(rawValue: 1 << 2)
    public static let shift   = ModifierState(rawValue: 1 << 3)

    public var isOptionOnly: Bool {
        self == [.option]
    }
}
