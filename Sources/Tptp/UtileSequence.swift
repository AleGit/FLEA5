//  Copyright © 2017 Alexander Maringele. All rights reserved.

import Foundation

/*
extension Collection {
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

extension Sequence {
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

/* postbone after talk */
typealias MultiSet<T: Hashable> = [T: Int]

/* postbone after talk */
extension Sequence where Element: Hashable {
    var multiSet: MultiSet<Element> {
        var d = MultiSet<Element>()
        for element in self {
            d[element] = (d[element] ?? 0) + 1
        }
        return d
    }
}
*/
// MARK: - utile iterator and sequence /* ******************* */

struct UtileIterator<S, T>: IteratorProtocol {
    private var this: S?
    private let step: (S) -> S?
    private let data: (S) -> T
    private let predicate: (S) -> Bool

    /// a iterator may outlive its creator,
    /// hence the functions `step`, `predicate`, and `data` may escape their context.
    init(first: S?, step: @escaping (S) -> S?, where
        predicate: @escaping (S) -> Bool = { _ in true }, data: @escaping (S) -> T) {
        this = first
        self.step = step
        self.data = data
        self.predicate = predicate
    }

    mutating func next() -> T? {
        while let current = self.this {
            this = step(current)

            if predicate(current) {
                return data(current)
            }
        }

        return nil
    }
}

struct UtileSequence<S, T>: Sequence {
    private let this: S?
    private let step: (S) -> S?
    private let predicate: (S) -> Bool
    private let data: (S) -> T

    /// a sequence may outlive its creator,
    /// hence the functions `step`, `predicate`, and `data` may escape their context.
    init(first: S?, step: @escaping (S) -> S?, where
        predicate: @escaping (S) -> Bool = { _ in true }, data: @escaping (S) -> T) {
        this = first
        self.step = step
        self.predicate = predicate
        self.data = data
    }

    func makeIterator() -> UtileIterator<S, T> {
        UtileIterator(first: this, step: step, where: predicate, data: data)
    }
}

