import XCTest
import Base
import Utile

public class ATestCase: XCTestCase {
    /// set up logging once _before_ all tests of a test class
    public override class func setUp() {
        super.setUp()
        Syslog.openLog(options: .console, .pid, .perror, verbosely: false)
    }

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {
        Syslog.closeLog()
        super.tearDown()
    }

    public func testTest() {
        print("*️⃣", type(of: self))
    }
}

extension ATestCase {

    enum `Type` {
        case predicate, function, variable
    }

    final class Node: Utile.Term {
        static var variable = `Type`.variable
        static var function = `Type`.function
        static var predicate = `Type`.predicate

        let symbol: String
        var key : String { return symbol }
        let type : `Type`
        let nodes : [Node]?

        private init(symbol: String, type: `Type`, nodes: [Node]?) {
            self.symbol = symbol
            self.type = type
            self.nodes = nodes
        }

        static func term(_ type: `Type`, _ symbol: String, nodes: [Node]?) -> Node {
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