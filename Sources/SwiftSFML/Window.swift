private import CxxSFML

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

/// Indicates the state of a window.
public enum WindowState: Int, Sendable {

    /// A floating window.
    case windowed = 0

    /// A fullscreen window.
    case fullscreen = 1
}

extension WindowState {

    var sfValue: sf.State {
        switch self {

        case .windowed:
            .Windowed

        case .fullscreen:
            .Fullscreen
        }
    }
}

/// Indicates a system event that just happened.
public enum Event: Sendable {

    /// A window has been closed.
    case closed

    /// A window has been resized.
    case resized(width: UInt32, height: UInt32)

    /// A window has lost focus.
    case focusLost

    /// A window has gained focus.
    case focusGained

    /// A character has been typed. This must not be confused with the `keyPressed` event. The `textEntered` event
    /// interprets the user input and produces the appropriate printable character.
    case textEntered(Unicode.Scalar)

    case keyPressed(code: KeyCode, scancode: KeyScancode, modifiers: KeyModifiers)

    case keyReleased(code: KeyCode, scancode: KeyScancode, modifiers: KeyModifiers)
}

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
