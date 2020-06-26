import XCTest
@testable import Utile

final class SubstitutionTests : ATestCase {

    func testIsHomogenous() {
        XCTAssertTrue(["a": "b"].isHomogenous)
        XCTAssertTrue([1: 1].isHomogenous)

        XCTAssertTrue([Int: Int]().isHomogenous)
        XCTAssertTrue([String: String]().isHomogenous)

        XCTAssertFalse(["a": 1].isHomogenous)
        XCTAssertFalse([1: "a"].isHomogenous)

        XCTAssertFalse([Int: String]().isHomogenous)
        XCTAssertFalse([String: Int]().isHomogenous)
    }

    func testApply() {
        let a = TermTests.Node.term(.function, "a", nodes: [TermTests.Node]())
        let y = TermTests.Node.variable("y")

        let s = [y : a]

        XCTAssertTrue(s.isSubstitution)
        XCTAssertFalse(s.isVariableSubstitution)

        for f in [ a, y] {
            XCTAssertEqual(a, f * s, f.description)
        }

        let fay = TermTests.Node.term(.function, "f", nodes: [a,y])
        let fya = TermTests.Node.term(.function, "f", nodes: [y,a])
        let fyy = TermTests.Node.term(.function, "f", nodes: [y,y])
        let faa = TermTests.Node.term(.function, "f", nodes: [a,a])

        for f in [ faa, fay, fya, fyy] {
            XCTAssertEqual(faa, f * s, f.description)
        }

    }
}


