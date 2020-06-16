import CTptpParsing
import Nodes
import Runtime

extension Tptp {
    public final class Node: Nodes.Node {
        public typealias Symbol = String
        public typealias SymbolType = PRLC_TREE_NODE_TYPE
        public typealias SymbolKey = Int

        // MARK: - public protocol properties

        /// The symbol of the node, e.g. "f".
        public var symbol: String {
            Tptp.Node.symbols[key].symbol
        }

        /// The TPTP type of the node, e.g. function.
        public var type: PRLC_TREE_NODE_TYPE {
            Tptp.Node.symbols[key].type
        }

        /// The key of the node, e.g. 1 with [ 1: "f" ]
        public let key: Int

        /// The children of the node, e.g. [X, z].
        public let nodes: [Node]?

        // MARK: - private static tables and functions

        // Lookup for symbols by key, e.g. symbols[3] -> ("f", function)
        private static var symbols = [(symbol: String, type: SymbolType)]()

        // Lookup for key by symbols, e.g. table["f"] -> 3
        private static var table = [String: Int]()

        // All (shared) nodes
        private static var pool = Set<Node>()

        private static func symbolize(_ type: PRLC_TREE_NODE_TYPE, _ symbol: String) -> Int {
            guard let key = Node.table[symbol] else {
                // symbol was not encountered before
                let count = Node.symbols.count
                Node.table[symbol] = count
                Node.symbols.append((symbol, type))
                return count
            }

            return key
        }


        private init(key: Int, nodes: [Node]?) {
            self.key = key
            self.nodes = nodes
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
                assert(count == 2)
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
