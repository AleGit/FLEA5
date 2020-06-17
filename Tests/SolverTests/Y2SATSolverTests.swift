import XCTest
import Runtime
@testable import Solver

class Y2SATSolverTests: Y2TestCase, HasSolver {
    lazy var solver: Solver = Y2SATSolver()

    func testVersion() {
        let expected = "Yices2 • 2.6.2"
        let actual = solver.description

        Syslog.notice { actual }
        Syslog.debug { solver.debugDescription }
        XCTAssertEqual(expected, actual)
    }
}
