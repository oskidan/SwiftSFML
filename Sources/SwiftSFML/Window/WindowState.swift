private import CxxSFML

/// Indicates the state of a window.
public enum WindowState: Int, Sendable {

    /// A floating window.
    case windowed = 0

    /// A fullscreen window.
    case fullscreen = 1
}

extension WindowState {

    var sfValue: sf.State {
        switch self {

        case .windowed:
            .Windowed

        case .fullscreen:
            .Fullscreen
        }
    }
}
