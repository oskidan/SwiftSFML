import Foundation

/// Window style options.
public struct WindowStyle: OptionSet, Sendable {

    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// A window without a border and title bar.
    public static let none = Self()

    /// A window with a title bar.
    public static let titlebar = Self(rawValue: 0b001)

    /// A window with a resizable border.
    public static let resize = Self(rawValue: 0b010)

    /// A window with a close button.
    public static let close = Self(rawValue: 0b100)

    /// A window with a title bar, a resizable border, and close button.
    public static let `default` = Self([.titlebar, .resize, .close])
}
