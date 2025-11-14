import SwiftSFML

var window = RenderWindow(
    width: 1024,
    height: 720,
    title: "TestApp"
)

window.frameRate = 60

while window.isOpen {

    while let event = window.pollEvent() {
        switch event {
        case .closed:
            window.close()

        case .resized(width: let width, height: let height):
            print("\(width)x\(height)")
        }
    }

    window.clear()
    window.display()
}
