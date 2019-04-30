

public final class StringNode {
    public let symbol : String
    public let nodes : [StringNode]?

    private static var shared = Set<StringNode>()

    private init(symbol: String, nodes: [StringNode]?) {
        self.symbol = symbol
        self.nodes = nodes
    }
}

extension StringNode : Node {
    private static func share(_ node: StringNode) -> StringNode {
        return shared.insert(node).memberAfterInsert
    }

    public static func create(variable: String) -> StringNode {
        return share(
            StringNode(
                symbol: variable,
                nodes: nil
            ) 
        )
    }

    public static func create(constant: String) -> StringNode {
        return create(function: constant, nodes: [StringNode]())
    }

    public static func create(function: String, nodes: [StringNode]) -> StringNode {
        return share(
            StringNode(
                symbol: function,
                nodes: nodes.map { share($0) }
            ) 
        )
    }
}