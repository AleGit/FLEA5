import XCTest
import Base
@testable import Solver

final class Z3SATSolverTests : Z3TestCase, HasSolver {
    lazy var solver: Solver = Z3SATSolver()

    func testVersion() {
        let expected = "Z3 • 4.8.8.0"
        let actual = solver.description

        Syslog.notice { actual }
        XCTAssertEqual(expected, actual)
        Syslog.debug { solver.debugDescription }
    }
}
