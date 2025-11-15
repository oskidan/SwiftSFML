private import CxxImGui

public enum ImGui {

    /// Demonstrates most ImGui features.
    public static func showDemoWindow() {
        CxxImGui.ImGui.ShowDemoWindow()
    }

    /// Pushes a new ImGui window, and, if the window is not collapsed, calls `body` to draw the contents of the window.
    public static func window(_ windowTitle: String, body: () -> Void) {
        let isBodyVisible = windowTitle.withCString {
            CxxImGui.ImGui.Begin($0)
        }
        defer { CxxImGui.ImGui.End() }

        guard isBodyVisible else {
            return
        }

        body()
    }
}
