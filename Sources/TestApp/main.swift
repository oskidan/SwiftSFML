import SwiftSFML

var window = RenderWindow(
    width: 1024,
    height: 720,
    title: "TestApp"
)

window.frameRate = 60
if !window.enableImGui() {
    fatalError("Could not enable ImGui.")
}

var clock = Clock()

while window.isOpen {

    while let event = window.pollEvent() {
        switch event {
        case .closed:
            window.close()

        case .resized(width: let width, height: let height):
            print("\(width)x\(height)")
        }
    }

    window.updateImGui(clock.restart())

    ImGui.showDemoWindow()

    window.clear(color: .init(r: 100, g: 150, b: 250))
    window.renderImGui()
    window.display()
}
