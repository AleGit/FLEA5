import XCTest
import AlgDat

final class NodeTests : XCTestCase {
}

extension NodeTests {
    enum `Type` {
        case predicate, function, variable
    }

    final class Node: AlgDat.Term {
        static var variable = `Type`.variable

        let symbol: String
        var key : String { return symbol }
        let type : `Type`
        let nodes : [Node]?

        private init(symbol: String, type: `Type`, nodes: [Node]?) {
            self.symbol = symbol
            self.type = type
            self.nodes = nodes
        }

        static func create(_ type: `Type`, _ symbol: String, nodes: [Node]?) -> Node {
            return Node(symbol: symbol, type: type, nodes: nodes)
        }

        var description: String {
            guard let args = nodes?.map({ $0.description }), args.count > 0 else {
                return symbol
            }

            return "\(symbol)(\(args.joined(separator: ",")))"
        }
    }
}