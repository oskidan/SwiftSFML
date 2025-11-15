#pragma once
#include <SFML/Graphics.hpp>

/// A helper for the `sf::RenderWindow::isOpen()` member function. This function is inherited from the `sf::Window`
/// class. As of the 14th of Nov 2025, the C++ interoperability layer produces separate Swift structs for C++ classes.
/// Because of that, sometimes the Swift compiler cannot find the `isOpen()` function on an `sf.RenderWindow`.
static inline auto isOpen(sf::RenderWindow const& window) -> bool {
    return window.isOpen();
}

/// A helper for the `sf::RenderWindow::pollEvent()` member function. This function is inherited from the `sf::Window`
/// class. As of the 14th of Nov 2025, the C++ interoperability layer produces separate Swift structs for C++ classes.
/// Because of that, sometimes the Swift compiler cannot find the `pollEvent()` function on an `sf.RenderWindow`.
static inline auto pollEvent(sf::RenderWindow& window) -> std::optional<sf::Event> {
    return window.pollEvent();
}

/// A helper for `sf::RenderTarget::draw(sf::Drawable const&, sf::RenderStates const&)` when the render target is
/// an instance of `sf::RenderWindow` and the drawable is an instance of `sf::CircleShape`. As of the 15th of Nov 2025,
/// the C++ interoperability layer produces Swift structs for C++ classes and sometimes it does not know how to call a
/// C++ virtual function.
static inline auto drawToWindow(sf::RenderWindow& window, sf::CircleShape const& shape) -> void {
    window.draw(shape);
}
