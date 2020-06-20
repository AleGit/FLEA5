import XCTest
@testable import Utile

final class SubstitutionTests : AbstractTestCase {

    func testApply() {
        let a = TermTests.Node.term(.function, "a", nodes: [TermTests.Node]())
        let y = TermTests.Node.variable("y")

        let s = [y : a]

        XCTAssertTrue(s.isSubstitution)
        XCTAssertFalse(s.isVariableSubstitution)
        XCTAssertFalse(s.isRenaming)

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


