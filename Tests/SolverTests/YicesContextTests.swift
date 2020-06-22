import XCTest
import Base
@testable import Solver

class Y2ContextTests: Y2TestCase {

    func testVersion() {
        let expected = "Yices2 • 2.6.2"
        let actual = Yices.Context().description

        Syslog.notice { actual }
        Syslog.debug { Yices.Context().solverName }
        XCTAssertEqual(expected, actual)
    }
}
