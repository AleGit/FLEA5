import CTptpParsing
import Nodes
import Runtime

extension Tptp {
    public final class Node: Nodes.Node {
        // symbols[3] -> "f"
        private static var symbols = [(symbol: String, type: SymbolType)]()
        // table["f"] -> ("f", function)
        private static var table = [String: Int]()
        private static var pool = Set<Node>()

        public let key: Int
        public let nodes: [Node]?

        private init(key: Int, nodes: [Node]?) {
            self.key = key
            self.nodes = nodes
        }

        public var symbol: String {
            return Tptp.Node.symbols[key].symbol
        }

        public var type: PRLC_TREE_NODE_TYPE {
            return Tptp.Node.symbols[key].type
        }

        private static func symbolize(_ type: PRLC_TREE_NODE_TYPE, _ symbol: String) -> Int {
            if Node.table[symbol] == nil {
                Node.table[symbol] = Node.symbols.count
                Node.symbols.append((symbol, type))
            }

            return Node.table[symbol]!
        }

        public static func create(_ type: PRLC_TREE_NODE_TYPE, _ symbol: String, nodes: [Node]? = nil) -> Node {
            let key = Node.symbolize(type, symbol)
            let node = Node(key: key, nodes: nodes)

            return pool.insert(node).memberAfterInsert
        }

        fileprivate static func create(tree parent: TreeNodeRef) -> Node? {
            let children = parent.children.compactMap {
                child in
                Node.create(tree: child)
            }

            return Node.create(parent.type, parent.symbol ?? "n/a", nodes: children)
        }

        public lazy var description: String = {
            guard let children = nodes?.map({ $0.description }) else {
                assert(self.type == PRLC_VARIABLE)
                return symbol
            }

            let count = children.count

            switch (self.type, self.symbol, count) {
            case (PRLC_FILE, _,_):
                let list = children.joined(separator: "\n")
                return "\(symbol)\n\(list)"

            case (PRLC_FOF, _,_):
                assert(count > 0)
                return "fof(\(symbol),\(children.first!),\n\t( \(children.last!) ))."

            case (PRLC_QUANTIFIER, _,_):
                let variables = children[..<(count - 1)].map { $0 }.joined(separator: ",")
                return "\(symbol) [\(variables)] :\n\t( \(children.last!) )"

            case (PRLC_CONNECTIVE, _, 1):
                return "\(symbol) \(children.first!)"

            case (PRLC_CONNECTIVE, _, 2):
                return "\(children.first!) \(symbol) \(children.last!)"

            case (PRLC_EQUATIONAL, _, _):
                assert(count == 2)
                return "\(children.first!) \(symbol) \(children.last!)"

            // variable, constant function, role
            case (_, _, 0):
                return symbol

            default:
                let terms = children.joined(separator: ",")
                return "\(symbol)(\(terms))"
            }
        }()
    }
}

extension Tptp.Node {
    static func create(file: Tptp.File) -> Tptp.Node? {
        guard let root = file.root else {
            return nil
        }
        return Tptp.Node.create(tree: root)
    }
}
