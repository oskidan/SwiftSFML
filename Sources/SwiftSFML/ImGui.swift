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

    /// Creates a slider for changing an `Int32` value.
    /// - Parameter label: a label next to the slider.
    /// - Parameter value: the value being modified by the slider.
    /// - Parameter range: the range of values that the slider produces.
    /// - Parameter onChanged: a closure to be called when the slider value has changed.
    public static func slider(
        _ label: String,
        value: inout Int32,
        in range: ClosedRange<Int32>,
        onChanged: (() -> Void)? = nil
    ) {
        let hasChanged = label.withCString {
            CxxImGui.ImGui.SliderInt($0, &value, range.lowerBound, range.upperBound)
        }

        guard hasChanged else {
            return
        }

        onChanged?()
    }

    /// Creates a slider for changing an `Int` value.
    /// - Parameter label: a label next to the slider.
    /// - Parameter value: the value being modified by the slider.
    /// - Parameter range: the range of values that the slider produces.
    /// - Parameter onChanged: a closure to be called when the slider value has changed.
    public static func slider(
        _ label: String,
        value: inout Int,
        in range: ClosedRange<Int>,
        onChanged: (() -> Void)? = nil
    ) {
        var i32Value = Int32(clamping: value)
        let i32Range = ClosedRange(
            uncheckedBounds: (
                lower: Int32(clamping: range.lowerBound),
                upper: Int32(clamping: range.upperBound)
            )
        )

        let hasChanged = label.withCString {
            CxxImGui.ImGui.SliderInt($0, &i32Value, i32Range.lowerBound, i32Range.upperBound)
        }

        guard hasChanged else {
            return
        }

        value = Int(i32Value)
        onChanged?()
    }
}
