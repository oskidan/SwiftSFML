private import CxxSFML

/// A shape representing a circle. The circle is faked with multiple triangles connected to each other. The `pointCount`
/// property defines how many of these triangles to use, and therefore defines the quality of the circle.
///
/// The number of points can also be used for another purpose; with small numbers you can create any regular polygon
/// shape: equilateral triangle, square, pentagon, hexagon, etc.
public struct CircleShape {

    var guts: sf.CircleShape
}

extension CircleShape {

    public init(radius: Float = 0, pointCount: Int = 30) {
        guts = sf.CircleShape(radius, pointCount)
    }

    /// The number of points on the circle. The circle is faked with multiple triangles connected to each other.
    /// The `pointCount` property defines how many of them to use, and therefore defines the quality of the circle.
    ///
    /// The number of points can also be used for another purpose; with small numbers you can create any regular polygon
    /// shape: equilateral triangle, square, pentagon, hexagon, etc.
    public var pointCount: Int {
        get {
            guts.getPointCount()
        }

        mutating set {
            guts.setPointCount(newValue)
        }
    }

    /// The circle radius.
    public var radius: Float {
        get {
            guts.getRadius()
        }

        mutating set {
            guts.setRadius(newValue)
        }
    }
}

extension CircleShape: Drawable {

    public func draw(to window: inout RenderWindow) {
        drawToWindow(&window.guts, self.guts)
    }
}
