import XCTest
@testable import Solver

final class Z3SATSolverTests : XCTestCase {
    let solver = Z3SATSolver()

    override class func setUp() {
        super.setUp()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func testVersion() {
        XCTAssertEqual(solver.description, "Z3 v4.5.1.0")
    }
}
