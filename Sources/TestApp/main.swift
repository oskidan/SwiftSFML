import SwiftSFML

var window = RenderWindow(
    width: 1024,
    height: 720,
    title: "TestApp"
)

window.frameRate = 60

// Try commenting this out to see the ImGui UI disappear.
if !window.enableImGui() {
    fatalError("Could not enable ImGui.")
}

var clock = Clock()

while window.isOpen {

    while let event = window.pollEvent() {
        switch event {

        case .closed:
            print("Closed.")
            window.close()

        case .resized(width: let width, height: let height):
            print("Resized to \(width)x\(height).")

        case .focusLost:
            print("Focus lost.")

        case .focusGained:
            print("Focus gained.")

        case .textEntered(let scalar):
            print(scalar)
        }
    }

    window.updateImGui(clock.restart())

    if window.isImGuiEnabled {
        ImGui.showDemoWindow()
    }

    window.clear(color: .init(r: 100, g: 150, b: 250))
    window.renderImGui()
    window.display()
}
