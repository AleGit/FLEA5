//  Copyright © 2017 Alexander Maringele. All rights reserved.

import Foundation

extension Swift.Collection {
    /// Split a collection in a pair of its first element and the remaining elements.
    ///
    /// - [] -> nil
    /// - [a,...] -> (a,[...])
    ///
    /// _Complexity_: O(1) -- `first` and `dropFirst()` are O(1) for collections
    var decomposing: (head: Self.Element, tail: Self.SubSequence)? {
        guard let head = first else { return nil }
        return (head, dropFirst()) //
    }
}

extension Swift.Sequence {
    /// check if a predicate holds for all members of a sequence
    func all(_ predicate: (Element) -> Bool) -> Bool {
        return reduce(true) { $0 && predicate($1) }
    }

    /// check if a predicate holds for at least one member of a sequence
    func one(_ predicate: (Element) -> Bool) -> Bool {
        return reduce(false) { $0 || predicate($1) }
    }

    /// count the members of a sequence where a predicate holds
    func count(_ predicate: (Element) -> Bool = { _ in true }) -> Int {
        return reduce(0) { $0 + (predicate($1) ? 1 : 0) }
    }
}
