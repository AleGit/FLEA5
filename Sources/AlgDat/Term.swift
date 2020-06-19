/// A tree data structure can be defined recursively as a collection of nodes
/// (starting at a root node), where each node is a data structure consisting
/// of a value, together with a list of references to nodes (the "children"),
/// with the constraints that no reference is duplicated, and none points to the root.
/// <a href="https://en.wikipedia.org/wiki/Tree_(data_structure)">wikipedia</a>
public protocol Term: Hashable, CustomStringConvertible { // , CustomDebugStringConvertible {
    associatedtype Symbol
    associatedtype SymbolType : Equatable
    associatedtype SymbolKey : Hashable

    /// The symbol of the node, e.g. "f".
    var symbol: Symbol { get }
    /// The type of the node, e.g. function, connective, quantifier
    var type: SymbolType { get }

    /// The key of the node, e.g. 1 with [ 1: "f" ]
    var key: SymbolKey { get }
    /// The children of the node, e.g. X, z.
    var nodes: [Self]? { get }

    static func create(_ type: SymbolType, _ symbol: Symbol, nodes: [Self]?) -> Self

    static var variable : SymbolType { get }
    static var function : SymbolType { get }
    static var predicate : SymbolType { get }
}

extension Term {
    /// Equatable
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        guard lhs.key == rhs.key, lhs.nodes == rhs.nodes else {
            return false
        }
        return true
    }

    /// Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(nodes)
    }

    public static func variable(_ symbol: Symbol) -> Self {
        Self.create(variable, symbol, nodes: nil)
    }

    public static func constant(_ symbol: Symbol) -> Self {
        Self.create(function, symbol, nodes: [Self]())
    }

    public static func function(_ symbol: Symbol, nodes: [Self]) -> Self {
        assert( nodes.reduce(true, { result, term in result && (term.type == variable || term.type == function) } ))
        return Self.create(function, symbol, nodes: nodes)
    }

    public static func predicate(_ symbol: Symbol, nodes: [Self]) -> Self {
        assert( nodes.reduce(true, { result, term in result && (term.type == variable || term.type == function) } ))
        return Self.create(predicate, symbol, nodes: nodes)
    }
}

extension Term {
    public var isVariable: Bool {
        return self.type == Self.variable
    }

    public var variables: Set<Self> {
        guard let nodes = self.nodes else {
            return Set(arrayLiteral: self)
        }
        return Set(nodes.flatMap {
            $0.variables
        })
    }
}
