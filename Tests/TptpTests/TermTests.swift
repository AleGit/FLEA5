@testable import Tptp
import CTptpParsing
import XCTest

final class TermTests: AbstractTestCase {
    typealias N = Tptp.Term

    let x = N.variable("X")
    let c = N.constant("c")
    let fxc = N.function("f", nodes: [N.variable("X"), N.constant("c")])
    let p = N.predicate("p",
            nodes: [
                N.variable("X"),
                N.constant("c"),
                N.function("f", nodes: [N.variable("X"), N.constant("c")])
            ]
    )

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
        XCTAssertEqual(0, c.nodes?.count)
    }

    func testFunction() {
        XCTAssertEqual("f", fxc.symbol)
        XCTAssertEqual(2, fxc.key)
        XCTAssertEqual(PRLC_FUNCTION, fxc.type)
        XCTAssertEqual(2, fxc.nodes?.count)

        // sharing!
        XCTAssertTrue(fxc.nodes?.first === x)
        XCTAssertTrue(fxc.nodes?.last === c)
    }

    func testPredicate() {
        XCTAssertEqual("p", p.symbol)
        XCTAssertEqual(3, p.key)
        XCTAssertEqual(PRLC_PREDICATE, p.type)
        XCTAssertEqual(3, p.nodes?.count)

        XCTAssertTrue(p.nodes?[0] === x)
        XCTAssertTrue(p.nodes?[1] === c)
        XCTAssertTrue(p.nodes?[2] === fxc)
    }
}
