private import CxxSFML

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
