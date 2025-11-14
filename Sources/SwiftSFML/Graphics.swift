private import CxxSFML
private import CxxStdlib
private import CxxImGui

/// A window that can serve as a target for 2D drawing.
public struct RenderWindow: ~Copyable {

    var guts: sf.RenderWindow

    /// Whether the ImGui is enabled for this window.
    public private(set) var isImGuiEnabled: Bool = false


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

extension RenderWindow {

    /// Enables ImGui in the window.
    /// - Returns: whether ImGui has been enabled.
    public mutating func enableImGui() -> Bool {
        isImGuiEnabled = CxxImGui.initialize(&guts)
        return isImGuiEnabled
    }

    /// Disables ImGui in the window.
    public mutating func disableImGui() {
        CxxImGui.shutdown(guts)
        isImGuiEnabled = false
    }

    /// Asks ImGui to process the given SFML event.
    private mutating func processImGuiEvent(_ event: sf.Event) {
        guard isImGuiEnabled else {
            return
        }
        CxxImGui.processEvent(guts, event)
    }

    /// Updates the ImGui internal state.
    public mutating func updateImGui(_ elapsedTime: Time) {
        guard isImGuiEnabled else {
            return
        }
        CxxImGui.ImGui.SFML.Update(&guts, elapsedTime.guts)
    }

    /// Renders the ImGui-managed UI.
    public mutating func renderImGui() {
        guard isImGuiEnabled else {
            return
        }
        CxxImGui.ImGui.SFML.Render(&guts)
    }
}

/// An RGBA color.
public struct Color: Sendable {

    let r: UInt8
    let g: UInt8
    let b: UInt8
    let a: UInt8

    public init(
        r: UInt8,
        g: UInt8,
        b: UInt8,
        a: UInt8 = 255
    ) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
}

extension Color {

    var sfValue: sf.Color {
        .init(r, g, b, a)
    }

    public static let black = Self(r: 0, g: 0, b: 0)

    public static let white = Self(r: 255, g: 255, b: 255)

    public static let red = Self(r: 255, g: 0, b: 0)

    public static let green = Self(r: 0, g: 255, b: 0)

    public static let blue = Self(r: 0, g: 0, b: 255)

    public static let yellow = Self(r: 255, g: 255, b: 0)

    public static let magenta = Self(r: 255, g: 0, b: 255)

    public static let cyan = Self(r: 0, g: 255, b: 255)

    public static let transparent = Self(r: 0, g: 0, b: 0, a: 0)
}
