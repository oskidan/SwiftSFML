import SwiftSFML

// Usage:
//  - Press Ctrl+I to enable/disable ImGui. ImGui is disabled by default.

var window = RenderWindow(
    width: 1024,
    height: 720,
    title: "TestApp"
)

window.frameRate = 60

var clock = Clock()

var shape = CircleShape(radius: 100.0)
shape.fillColor = .green

var say = "Hello, World!"

while window.isOpen {

    while let event = window.pollEvent() {
        switch event {

        case .closed:
            print("Closed.")
            window.close()

        case .resized(let width, let height):
            print("Resized to \(width)x\(height).")

        case .focusLost:
            print("Focus lost.")

        case .focusGained:
            print("Focus gained.")

        case .textEntered(let scalar):
            print(scalar)

        case .keyPressed(let code, let scancode, let modifiers):
            print("Key pressed: \(code) \(scancode) \(modifiers)")
            if modifiers.contains(.control) && code == .I {
                print("ImGui was \(window.toggleImGui() ? "enabled" : "disabled").")
            }

        case .keyReleased(let code, let scancode, let modifiers):
            print("Key released: \(code) \(scancode) \(modifiers)")
        }
    }

    window.updateImGui(clock.restart())

    if window.isImGuiEnabled {
        ImGui.window("Test Window") {
            ImGui.slider("Circle radius", value: &shape.radius, in: 0...100)
            ImGui.slider("Circle points", value: &shape.pointCount, in: 3...30)
            ImGui.colorEdit("Color circle", value: &shape.fillColor)
            ImGui.inputText("Say what?", value: &say)
            ImGui.text(say)
            ImGui.button("Click me!") {
                shape.fillColor = .randomRGB
            }
        }
    }

    window.clear(color: .init(r: 100, g: 150, b: 250))

    window.draw(shape)

    window.display()
}
