private import CxxSFML

public protocol Drawable {

    func draw(to window: inout RenderWindow)
}
