import XCTest
@testable import Solver

class Y2SATSolverTests: XCTestCase {
    var solver = Y2SATSolver()

    override class func setUp() {
        super.setUp()
}

    override class func tearDown() {
        super.tearDown()
    }

    func testVersion() {
        XCTAssertEqual(solver.description, "Yices2 v2.6.2")
    }
}
