//  Copyright (c) Oleksii Skidan 11/14/25.
//
// Helpers for binding to SFML ImGui.
#include "imgui.h"
#include "imgui-SFML.h"

#include <SFML/Graphics.hpp>

/// Initializes the ImGui binding for the given SFML window.
static inline auto initialize(sf::RenderWindow& window) -> bool {
    return ImGui::SFML::Init(window);
}

/// Shuts down the ImGui binding for the given SFML window.
static inline auto shutdown(sf::RenderWindow const& window) -> void {
    ImGui::SFML::Shutdown(window);
}

/// Asks ImGui to process a given event in a given window.
static inline auto processEvent(sf::RenderWindow const& window, sf::Event const& event) -> void {
    ImGui::SFML::ProcessEvent(window, event);
}
