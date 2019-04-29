import XCTest
import Nodes

final class SimpleNodeTests : XCTestCase {
    typealias N = SimpleNode

    let x = N.create(variable: "x")
    let c = N.create(constant: "c")
    let fxc = N.create(function: "f", nodes: [N.create(variable: "x"), N.create(constant: "c")])

    func testVariable() {
        XCTAssertEqual("x", x.symbol)
        XCTAssertNil(x.nodes)
    }
    
    func testConstant() {
        XCTAssertEqual("c", c.symbol)
        XCTAssertEqual(c.nodes?.count ?? -1, 0)
    }

    func testFunction() {
        XCTAssertEqual("f", fxc.symbol)
        XCTAssertEqual(fxc.nodes, [x, c])
        XCTAssertEqual(fxc.nodes?.count ?? -1, 2)

        XCTAssertTrue(fxc.nodes?.first == x)
        XCTAssertTrue(fxc.nodes?.last == c)
    }
}