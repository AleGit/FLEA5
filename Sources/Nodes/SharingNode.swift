

public final class SharingNode {
    public let symbol : String
    public let nodes : [SharingNode]?

    fileprivate static var shared = Set<SharingNode>()

    fileprivate init(symbol: String, nodes: [SharingNode]?) {
        self.symbol = symbol
        self.nodes = nodes
    }
}

extension SharingNode : Node {
    private static func share(_ node: SharingNode) -> SharingNode {
        return shared.insert(node).memberAfterInsert
    }

    public static func create(variable: String) -> SharingNode {
        return share(
            SharingNode(
                symbol: variable,
                nodes: nil
            ) 
        )
    }

    public static func create(constant: String) -> SharingNode {
        return create(function: constant, nodes: [SharingNode]())
    }

    public static func create(function: String, nodes: [SharingNode]) -> SharingNode {
        return share(
            SharingNode(
                symbol: function,
                nodes: nodes.map { share($0) }
            ) 
        )
    }
}