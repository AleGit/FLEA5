

public final class IntegerNode {
    public let symbol : Int
    public let nodes : [IntegerNode]?

    private static var shared = Set<IntegerNode>()
    private static var symbols = ["*"]
    private static var mapping = ["*" : 0]

    private init(symbol: Int, nodes: [IntegerNode]?) {
        self.symbol = symbol
        self.nodes = nodes
    }
}

extension IntegerNode : Node {
    private static func share(_ node: IntegerNode) -> IntegerNode {
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

    public static func create(variable: String) -> IntegerNode {
        return share(
            IntegerNode(
                symbol: symbol(variable),
                nodes: nil
            ) 
        )
    }

    public static func create(constant: String) -> IntegerNode {
        return create(function: constant, nodes: [IntegerNode]())
    }

    public static func create(function: String, nodes: [IntegerNode]) -> IntegerNode {
        return share(
            IntegerNode(
                symbol: symbol(function),
                nodes: nodes.map { share($0) }
            ) 
        )
    }
}