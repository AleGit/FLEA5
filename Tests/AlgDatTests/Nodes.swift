import XCTest
import AlgDat

struct Nodes {
    enum Sort {
        case predicate, function, variable
    }
    final class Simple: AlgDat.Node {
        let symbol: String
        var key : String { return symbol }
        let type : Sort
        let nodes : [Simple]?

        private init(symbol: String, type: Sort, nodes: [Simple]?) {
            self.symbol = symbol
            self.type = type
            self.nodes = nodes
        }

        static func create(_ type: Sort, _ symbol: String, nodes: [Simple]?) -> Simple {
            return Simple(symbol: symbol, type: type, nodes: nodes)
        }

        var description: String {
            guard let args = nodes?.map({ $0.description }), args.count > 0 else {
                return symbol
            }

            return "\(symbol)(\(args.joined(separator: ",")))"
        }
    }

}