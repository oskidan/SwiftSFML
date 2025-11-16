private import CxxImGui

public enum ImGui {

    /// Demonstrates most ImGui features.
    public static func showDemoWindow() {
        CxxImGui.ImGui.ShowDemoWindow()
    }

    /// Pushes a new ImGui window, and, if the window is not collapsed, calls `body` to draw the contents of the window.
    /// - Parameter title: a title of the window.
    /// - Parameter body: a closure that knows how to create the window body.
    public static func window(_ title: String, body: () -> Void) {
        let isBodyVisible = title.withCString {
            CxxImGui.ImGui.Begin($0)
        }
        defer { CxxImGui.ImGui.End() }

        guard isBodyVisible else {
            return
        }

        body()
    }

    /// Creates a slider for changing a `Float` value.
    /// - Parameter label: a label next to the slider.
    /// - Parameter value: the value being modified by the slider.
    /// - Parameter range: the range of values that the slider produces.
    /// - Parameter onChanged: a closure to be called when the slider value has changed.
    public static func slider(
        _ label: String,
        value: inout Float,
        in range: ClosedRange<Float>,
        onChanged: (() -> Void)? = nil
    ) {
        let hasChanged = label.withCString {
            CxxImGui.ImGui.SliderFloat($0, &value, range.lowerBound, range.upperBound)
        }

        guard hasChanged else {
            return
        }

        onChanged?()
    }
}
