private import CxxSFML

/// Indicates a set of keys that, when held down, change the function of another key pressed at the same time.
public struct KeyModifiers: OptionSet, Sendable {

    public let rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    /// Indicates that the Alt key has been pressed.
    public static let alt = Self(rawValue: 0b0001)

    /// Indicates that the Control/Option key has been pressed.
    public static let control = Self(rawValue: 0b0010)

    /// Indicates that the Shift key has been pressed.
    public static let shift = Self(rawValue: 0b0100)

    /// Indicates that the System/Command/Super key has been pressed.
    public static let system = Self(rawValue: 0b1000)
}

public typealias KeyCode = sf.Keyboard.Key

public typealias KeyScancode = sf.Keyboard.Scancode
