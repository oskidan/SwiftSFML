private import CxxSFML
private import CxxImGui

extension RenderWindow {

    /// Enables ImGui in the window.
    /// - Returns: whether ImGui has been enabled.
    public mutating func enableImGui() -> Bool {
        guard !isImGuiEnabled else {
            return true
        }
        isImGuiEnabled = CxxImGui.initialize(&guts)
        return isImGuiEnabled
    }

    /// Disables ImGui in the window.
    public mutating func disableImGui() {
        guard isImGuiEnabled else {
            return
        }
        CxxImGui.shutdown(guts)
        isImGuiEnabled = false
    }

    /// Enables/disables ImGui in the window.
    /// - Returns: whether ImGui has been enabled.
    public mutating func toggleImGui() -> Bool {
        if isImGuiEnabled {
            disableImGui()
        } else {
            _ = enableImGui()
        }
        return isImGuiEnabled
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
    mutating func renderImGui() {
        guard isImGuiEnabled else {
            return
        }
        CxxImGui.ImGui.SFML.Render(&guts)
    }
}
