

public final class IntNode {
    public let symbol : Int
    public let nodes : [IntNode]?

    fileprivate static var shared = Set<IntNode>()
    fileprivate static var symbols = ["*"]
    fileprivate static var mapping = ["*" : 0]

    fileprivate init(symbol: Int, nodes: [IntNode]?) {
        self.symbol = symbol
        self.nodes = nodes
    }
}

extension IntNode : Node {
    private static func share(_ node: IntNode) -> IntNode {
        return shared.insert(node).memberAfterInsert
    }

    private static func symbol(_ string: String) -> Int {
        if let index = mapping[string] {
            return index
        }
        else {
            let count = symbols.count
            symbols.append(string)
            mapping[string] = count
            return count
        }
    }

    public static func create(variable: String) -> IntNode {
        return share(
            IntNode(
                symbol: symbol(variable),
                nodes: nil
            ) 
        )
    }

    public static func create(constant: String) -> IntNode {
        return create(function: constant, nodes: [IntNode]())
    }

    public static func create(function: String, nodes: [IntNode]) -> IntNode {
        return share(
            IntNode(
                symbol: symbol(function),
                nodes: nodes.map { share($0) }
            ) 
        )
    }
}