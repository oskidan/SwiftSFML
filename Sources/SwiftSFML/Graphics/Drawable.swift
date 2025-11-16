private import CxxSFML

/// Types conforming to this protocol represent objects that can be drawn to a render target.
public protocol Drawable {

    /// Draws an object to the given window.
    func draw(to window: inout RenderWindow)
}
