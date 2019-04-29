import XCTest
import Nodes

final class IntegerNodeTests : XCTestCase {
    typealias N = IntegerNode

    let x = N.create(variable: "x")
    let c = N.create(constant: "c")
    let fxc = N.create(function: "f", nodes: [N.create(variable: "x"), N.create(constant: "c")])

    func testVariable() {
        XCTAssertEqual(1, x.symbol)
        XCTAssertNil(x.nodes)
    }
    
    func testConstant() {
        XCTAssertEqual(2, c.symbol)
        XCTAssertEqual(c.nodes?.count ?? -1, 0)
    }

    func testFunction() {
        XCTAssertEqual(3, fxc.symbol)
        XCTAssertEqual(fxc.nodes, [x, c])
        XCTAssertEqual(fxc.nodes?.count ?? -1, 2)

        // sharing!
        XCTAssertTrue(fxc.nodes?.first === x)
        XCTAssertTrue(fxc.nodes?.last === c)
    }
}