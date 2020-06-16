import XCTest
@testable import Solver

final class Z3SolverTests : XCTestCase {
    let solver : Z3Solver = Z3Solver.shared

    override class func setUp() {
        super.setUp()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func testVersion() {
        XCTAssertEqual(solver.description, "Z3 4.5.1.0")
    }
}
