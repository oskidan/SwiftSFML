private import CxxSFML

public struct Clock {

    var guts: sf.Clock
}

extension Clock {

    public init() {
        guts = sf.Clock()
    }

    /// - Returns: elapsed time, puts the clock back to zero, and leaves it in a running state.
    public mutating func restart() -> Time {
        Time(guts: guts.restart())
    }
}

public struct Time {

    let guts: sf.Time
}
