import Foundation

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

    /// A keyboard key has been pressed. If a key is held, multiple `keyPressed` events will be generated.
    case keyPressed(code: KeyCode, scancode: KeyScancode, modifiers: KeyModifiers)

    /// A keyboard key has been released.
    case keyReleased(code: KeyCode, scancode: KeyScancode, modifiers: KeyModifiers)
}
