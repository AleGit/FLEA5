import XCTest
@testable import Utile

class UnificationTests : ATestCase {
    typealias Σ = [Node:Node]
    func testBasics() {
        let a = Node.constant("a")
        let b = Node.constant("b")
        let x = Node.variable("x")
        let fa = Node.function("f", nodes: [a])
        let fb = Node.function("f", nodes: [b])
        let fx = Node.function("f", nodes: [x])
        let fab = Node.function("f", nodes: [a, b])
        let fax = Node.function("f", nodes: [a, x])
        let fxa = Node.function("f", nodes: [x, a])
        let fxx = Node.function("f", nodes: [x, x])
        let gxa = Node.function("g", nodes: [x, a])

        // trivial cases
        for t in [a,b,x,fa,fb,fx, fax, fxa, fxx, gxa, fab ] {
            XCTAssertEqual(Σ(), t =?= t)
        }

        // simple cases

        for (lhs, rhs) in [(a,x), (fax, fxx), (fxx, fxa), (fxa, fax) ] {
            let e = [x:a]
            XCTAssertEqual(e, lhs =?= rhs, "\(lhs) =?= \(rhs)")
            XCTAssertEqual(e, rhs =?= lhs, "\(rhs) =?= \(lhs)")
        }

        for (lhs, rhs) in [(x, fa)] {
            let e = [x:fa]
            XCTAssertEqual(e, lhs =?= rhs, "\(lhs) =?= \(rhs)")
            XCTAssertEqual(e, rhs =?= lhs, "\(rhs) =?= \(lhs)")
        }

        // not unifiable

        for (lhs, rhs) in [  (a, b),
                             (x, fx), (x, fax),
                             (fa,fb), (fxa, gxa),
        ] {
            let σ = lhs =?= rhs as Σ?
            XCTAssertNil(σ, "\(lhs) =?= \(rhs)")
            XCTAssertEqual(σ, rhs =?= lhs)

        }
    }
}
