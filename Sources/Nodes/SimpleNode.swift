

public final class SimpleNode {
    public let symbol : String
    public let nodes : [SimpleNode]?

    fileprivate init(symbol: String, nodes: [SimpleNode]?) {
        self.symbol = symbol
        self.nodes = nodes
    }
}

extension SimpleNode : Node {

    public static func create(variable: String) -> SimpleNode {
        
            return SimpleNode(
                symbol: variable,
                nodes: nil
            ) 
    }

    public static func create(constant: String) -> SimpleNode {
        return create(function: constant, nodes: [SimpleNode]())
    }

    public static func create(function: String, nodes: [SimpleNode]) -> SimpleNode {
        
            return SimpleNode(
                symbol: function,
                nodes: nodes
            ) 
    }
}