private import CxxSFML
private import CxxImGui

extension RenderWindow {

    /// Enables ImGui in the window.
    /// - Returns: whether ImGui has been enabled.
    public mutating func enableImGui() -> Bool {
        isImGuiEnabled = CxxImGui.initialize(&guts)
        return isImGuiEnabled
    }

    /// Disables ImGui in the window.
    public mutating func disableImGui() {
        CxxImGui.shutdown(guts)
        isImGuiEnabled = false
    }

    /// Asks ImGui to process the given SFML event.
    mutating func processImGuiEvent(_ event: sf.Event) {
        guard isImGuiEnabled else {
            return
        }
        CxxImGui.processEvent(guts, event)
    }

    /// Updates the ImGui internal state.
    public mutating func updateImGui(_ elapsedTime: Time) {
        guard isImGuiEnabled else {
            return
        }
        CxxImGui.ImGui.SFML.Update(&guts, elapsedTime.guts)
    }

    /// Renders the ImGui-managed UI.
    public mutating func renderImGui() {
        guard isImGuiEnabled else {
            return
        }
        CxxImGui.ImGui.SFML.Render(&guts)
    }
}
