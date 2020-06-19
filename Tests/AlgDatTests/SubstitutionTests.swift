import XCTest
@testable import AlgDat

final class SubstitutionTests : XCTestCase {



    func testApply() {
        let a = NodeTests.Node.create(.function, "a", nodes: [NodeTests.Node]())
        let y = NodeTests.Node.variable("y")

        let s = [y : a]

        XCTAssertTrue(s.isSubstitution)
        XCTAssertFalse(s.isVariableSubstitution)
        XCTAssertFalse(s.isRenaming)

        for f in [ a, y] {
            XCTAssertEqual(a, f * s, f.description)
        }

        let fay = NodeTests.Node.create(.function, "f", nodes: [a,y])
        let fya = NodeTests.Node.create(.function, "f", nodes: [y,a])
        let fyy = NodeTests.Node.create(.function, "f", nodes: [y,y])
        let faa = NodeTests.Node.create(.function, "f", nodes: [a,a])

        for f in [ faa, fay, fya, fyy] {
            XCTAssertEqual(faa, f * s, f.description)
        }

    }
}


