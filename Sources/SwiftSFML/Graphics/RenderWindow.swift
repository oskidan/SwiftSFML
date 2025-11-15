private import CxxSFML
private import CxxStdlib
private import CxxImGui

/// A window that can serve as a target for 2D drawing.
public struct RenderWindow: ~Copyable {

    var guts: sf.RenderWindow

    /// Whether the ImGui is enabled for this window.
    public internal(set) var isImGuiEnabled: Bool = false


    /// The desired frame rate. A value of `0` disables frame rate limit. The default value is `0`.
    public var frameRate: UInt32 = 0 {
        mutating didSet {
            guts.setFramerateLimit(frameRate)
        }
    }
}

extension RenderWindow {

    /// Creates a new window.
    public init(
        width: UInt32,
        height: UInt32,
        bitsPerPixel: UInt32 = 32,
        title: String,
        style: WindowStyle = .default,
        state: WindowState = .windowed
    ) {
        guts = sf.RenderWindow(
            sf.VideoMode(sf.Vector2u(width, height), bitsPerPixel),
            sf.String(std.u32string(title)),
            style.rawValue,
            state.sfValue,
            sf.ContextSettings()
        )
    }

    /// - Returns: Whether or not the window exists. A value of `true` indicates that the window exists.
    public var isOpen: Bool {
        CxxSFML.isOpen(guts)
    }

    /// Closes the window and destroys all the attached resources.
    public mutating func close() {
        guts.close()
    }

    /// - Returns: The next event from the front of the FIFO event queue, or `nil` if there's no pending event.
    public mutating func pollEvent() -> Event? {
        guard let event = CxxSFML.pollEvent(&guts).value else {
            return nil
        }

        processImGuiEvent(event)

        let eventVariant = CxxSFML.eventVariant(event)

        switch eventVariant.kind {
        case .Closed:
            return .closed

        case .Resized:
            return .resized(
                width: eventVariant.resized.size.x,
                height: eventVariant.resized.size.y
            )

        case .FocusLost:
            return .focusLost

        case .FocusGained:
            return .focusGained

        case .TextEntered:
            return .textEntered(eventVariant.textEntered.unicode)

        case .KeyPressed:
            var modifiers = KeyModifiers()
            if eventVariant.keyPressed.alt { modifiers.update(with: .alt) }
            if eventVariant.keyPressed.control { modifiers.update(with: .control) }
            if eventVariant.keyPressed.shift { modifiers.update(with: .shift) }
            if eventVariant.keyPressed.system { modifiers.update(with: .system) }
            return .keyPressed(
                code: eventVariant.keyPressed.code,
                scancode: eventVariant.keyPressed.scancode,
                modifiers: modifiers
            )

        case .KeyReleased:
            var modifiers = KeyModifiers()
            if eventVariant.keyReleased.alt { modifiers.update(with: .alt) }
            if eventVariant.keyReleased.control { modifiers.update(with: .control) }
            if eventVariant.keyReleased.shift { modifiers.update(with: .shift) }
            if eventVariant.keyReleased.system { modifiers.update(with: .system) }
            return .keyReleased(
                code: eventVariant.keyReleased.code,
                scancode: eventVariant.keyReleased.scancode,
                modifiers: modifiers
            )

        case .Unknown:
            return nil

        @unknown default:
            return nil
        }
    }

    /// Clears the window render target with a color and a stencil value.
    /// The specified stencil value will be truncated to the bit width of the current stencil buffer.
    public mutating func clear(color: Color = .black, stencil: UInt32 = 0) {
        guts.clear(color.sfValue, sf.StencilValue(stencil))
    }

    /// Displays on screen what has been rendered to the window so far.
    public mutating func display() {
        guts.display()
    }
}
