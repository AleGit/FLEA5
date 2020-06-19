import Foundation

/// A substitution is a mapping from keys to values, e.g. a dictionary.
public protocol Substitution: ExpressibleByDictionaryLiteral, Sequence, CustomStringConvertible {
    associatedtype K: Hashable
    associatedtype V

    subscript(_: K) -> V? { get set }

    init(dictionary: [K: V])
}

/// A dictionary is a substitution.
extension Dictionary: Substitution {
    public init(dictionary: [Key: Value]) {
        self = dictionary
    }
}

/// A node substitution has a specialized description.
extension Substitution // K == V not necessary
        where K: Node, V: Node, Iterator == DictionaryIterator<K, V> {
    var description: String {
        let pairs = map { "\($0)->\($1)" }.joined(separator: ",")
        return "{\(pairs)}"
    }
}
