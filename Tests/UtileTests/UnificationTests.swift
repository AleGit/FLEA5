import XCTest
@testable import Utile

class UnificationTests : ATestCase {
    typealias Σ = [Node:Node]
    func testBasics() {
        let a = Node.constant("a")
        let b = Node.constant("b")
        let x = Node.variable("x")
        let fax = Node.function("f", nodes: [a, x])
        let fxa = Node.function("f", nodes: [x, a])
        let fxx = Node.function("f", nodes: [x, x])
        let gxa = Node.function("g", nodes: [x, a])


        XCTAssertEqual(Σ(), a =?= a)

        XCTAssertNil(a =?= b as Σ?)
        XCTAssertNil(b =?= a as Σ?)

        XCTAssertEqual([x:a], a =?= x)
        XCTAssertEqual([x:a], a =?= x)

        XCTAssertEqual([ x:a ], fax =?= fxx)
        XCTAssertEqual([ x:a ], fax =?= fxa)

        XCTAssertEqual([ x:a ], fxx =?= fax)
        XCTAssertEqual([ x:a ], fxx =?= fxa)

        XCTAssertEqual([ x:a ], fxa =?= fax)
        XCTAssertEqual([ x:a ], fxa =?= fxx)

        XCTAssertNil( fxa =?= gxa as Σ? )
    }
}
