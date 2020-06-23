import Base
import Solver
import XCTest

class Z3ContextPublicTests {

    func testVersion() {
        let expected = "Z3 • 4.8.8.0"
        let actual = Z3.Context().description

        Syslog.notice { actual }
        XCTAssertEqual(expected, actual)
        Syslog.debug { Z3.Context().name }
    }
}
