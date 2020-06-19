import XCTest
@testable import AlgDat

final class SubstitutionTests : XCTestCase {



    func testApply() {
        let a = Nodes.Simple.create(.function, "a", nodes: [Nodes.Simple]())
        let y = Nodes.Simple.create(.variable, "y", nodes: nil)
        let fay = Nodes.Simple.create(.function, "f", nodes: [a,y])

        let s = [y : a]

        let faa = fay * s
        XCTAssertEqual(faa.description, "f(a,a)")


    }
}


