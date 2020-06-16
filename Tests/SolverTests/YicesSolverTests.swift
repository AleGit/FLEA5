import XCTest
@testable import Solver

class YicesTests: XCTestCase {
    var solver = YicesSolver.shared

    override class func setUp() {
        super.setUp()
}

    override class func tearDown() {
        super.tearDown()
    }

    func testVersion() {
        XCTAssertEqual(solver.description, "Yices 2.6.2")
    }
}
