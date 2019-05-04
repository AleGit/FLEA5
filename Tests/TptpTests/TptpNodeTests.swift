import Tptp
import CTptpParsing
import XCTest

final class TptpNodeTests: XCTestCase {
    typealias N = Tptp.Node

    let x = N.create(PRLC_VARIABLE, "X")
    let c = N.create(PRLC_FUNCTION, "c", nodes: [N]())
    let fxc = N.create(PRLC_FUNCTION, "f",
                       nodes: [
                           N.create(PRLC_VARIABLE, "X"), 
                           N.create(PRLC_FUNCTION, "c", nodes: [N]()),
                       ])

    func testVariable() {
        XCTAssertEqual("X", x.symbol)
        XCTAssertEqual(0, x.key)
        XCTAssertEqual(PRLC_VARIABLE, x.type)
        XCTAssertNil(x.nodes)
    }

    func testConstant() {

        XCTAssertEqual("c", c.symbol)
        XCTAssertEqual(1, c.key)
        XCTAssertEqual(PRLC_VARIABLE, x.type)
        XCTAssertEqual(c.nodes?.count, 0)
    }

    func testFunction() {
        XCTAssertEqual("f", fxc.symbol)
        XCTAssertEqual(2, fxc.key)
        XCTAssertEqual(PRLC_FUNCTION, fxc.type)
        XCTAssertEqual(fxc.nodes?.count, 2)

        // sharing!
        XCTAssertTrue(fxc.nodes?.first === x)
        XCTAssertTrue(fxc.nodes?.last === c)
    }
}
