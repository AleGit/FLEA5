import XCTest
@testable import Utile

class UnificationTests : ATestCase {
    func testBasics() {
        let a = Node.constant("a")
        let b = Node.constant("b")
        let x = Node.variable("x")
        let fax = Node.function("f", nodes: [a, x])
        let fxa = Node.function("f", nodes: [x, a])
        let fxx = Node.function("f", nodes: [x, x])

        let aa : Dictionary<Node,Node>? = a =?= a
        XCTAssertNotNil(aa)
        XCTAssertEqual(0, aa?.count)

        let ab : Dictionary<Node,Node>? = a =?= b
        let ba : Dictionary<Node,Node>? = b =?= a
        XCTAssertNil(ab)
        XCTAssertNil(ba)

        let ax : Dictionary<Node,Node>? = a =?= x
        let xa : Dictionary<Node,Node>? = x =?= a
        XCTAssertNotNil(ax)
        XCTAssertNotNil(xa)
        XCTAssertEqual(ax, xa)

        let σ = [ x:a ]
        XCTAssertEqual(σ, fax =?= fxx)
        XCTAssertEqual(σ, fax =?= fxa)

        XCTAssertEqual(σ, fxx =?= fax)
        XCTAssertEqual(σ, fxx =?= fxa)

        XCTAssertEqual(σ, fxa =?= fax)
        XCTAssertEqual(σ, fxa =?= fxx)
    }
}
