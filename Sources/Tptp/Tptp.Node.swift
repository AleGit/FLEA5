import CTptpParsing
import AlgDat
import Runtime

extension Tptp {
    public final class Node: AlgDat.Node {
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

        /// A symbol might be used multiple times with different types,
        /// e.g. name of annotated formula and constant in a formula,
        /// see agatha, butler, charles in [PUZ001-1.p](http://www.tptp.org/cgi-bin/SeeTPTP?Category=Problems&Domain=PUZ&File=PUZ001-1.p)
        /// - Parameters:
        ///   - type:
        ///   - symbol:
        /// - Returns:
        private static func merge(_ type: PRLC_TREE_NODE_TYPE, _ symbol: String) -> String {
            return "\(symbol)_\(type)"
        }

        private static func symbolize(_ type: PRLC_TREE_NODE_TYPE, _ symbol: String) -> Int {
            let st = merge(type, symbol)

            guard let key = Node.table[st] else {
                // symbol of type was not encountered before
                let count = Node.symbols.count
                Node.table[st] = count
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
            let node : Node
            switch type {
            case PRLC_VARIABLE:
                assert(nodes == nil || nodes?.count == 0, "\(type) \(symbol))")
                node = Node(key: key, nodes: nil)
            default:
                assert(nodes != nil)
                node = Node(key: key, nodes: nodes)
            }

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

            case (PRLC_CNF, _,_):
                assert(count == 2)
                return "cnf(\(symbol),\(children.first!),\n\t( \(children.last!) ))."

            case (PRLC_QUANTIFIER, _,_):
                let variables = children[..<(count - 1)].map { $0 }.joined(separator: ",")
                return "\(symbol) [\(variables)] :\n\t( \(children.last!) )"

            case (PRLC_CONNECTIVE, "~", 1):
                return "\(symbol)\(children.first!)"

            case (PRLC_CONNECTIVE, _, 1):
                return "\(children.first!)"

            case (PRLC_CONNECTIVE, _, _):
                return children.joined(separator: " \(symbol) ")

            case (PRLC_EQUATIONAL, _, _):
                assert(count == 2)
                return "\(children.first!) \(symbol) \(children.last!)"

            // variable, constant function, role
            case (_, _, 0):
                return symbol

            case (_, _, _):
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
