#pragma once
#include <SFML/Window/Event.hpp>

#include <utility> // for std::monostate

/// Enumerates which kinds of events are supported by SFML.
enum class EventKind : std::uint8_t { Unknown, Closed, Resized, FocusLost, FocusGained };

/// A Swift-friendly representation of events. As of the 14th of Nov 2025, C++ interoperability cannot meaningfully
/// represent `sf::Event` in Swift.
struct EventVariant {

    EventKind kind = EventKind::Unknown;

    union {
        std::monostate _ = {};

        sf::Event::Resized resized;
    };
};

/// Converts a given `sf::Event` to an `EventVariant`.
static inline auto eventVariant(sf::Event const &event) -> EventVariant {
    return event.visit([](auto &&event) {
        using EventType = std::decay_t<decltype(event)>;

        if constexpr (std::is_same_v<EventType, sf::Event::Closed>) {
            EventVariant variant;
            variant.kind = EventKind::Closed;
            return variant;
        }

        if constexpr (std::is_same_v<EventType, sf::Event::Resized>) {
            EventVariant variant;
            variant.kind = EventKind::Resized;
            variant.resized = event;
            return variant;
        }

        if constexpr (std::is_same_v<EventType, sf::Event::FocusLost>) {
            EventVariant variant;
            variant.kind = EventKind::FocusLost;
            return variant;
        }

        if constexpr (std::is_same_v<EventType, sf::Event::FocusGained>) {
            EventVariant variant;
            variant.kind = EventKind::FocusGained;
            return variant;
        }

        return EventVariant{};
    });
}
