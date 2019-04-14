/// A tree data structure can be defined recursively as a collection of nodes
/// (starting at a root node), where each node is a data structure consisting
/// of a value, together with a list of references to nodes (the "children"),
/// with the constraints that no reference is duplicated, and none points to the root.
/// <a href="https://en.wikipedia.org/wiki/Tree_(data_structure)">wikipedia</a>
public protocol Node : Hashable { // , CustomStringConvertible, CustomDebugStringConvertible {
    associatedtype Symbol: Hashable

    /// The Value of the node.
    var symbol: Symbol { get }

    /// References to nodes (the "children")
    var nodes: [Self]? { get }

    static func create(variable: String) -> Self
    static func create(constant: String) -> Self
    static func create(function: String, nodes: [Self]) -> Self
}