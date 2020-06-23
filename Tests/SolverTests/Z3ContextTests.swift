import XCTest
import Base
@testable import Solver

final class Z3ContextTests : Z3TestCase {

    func _testVersion() {
        let expected = "Z3 • 4.8.8.0"
        let actual = Z3.Context().description

        Syslog.notice { actual }
        XCTAssertEqual(expected, actual)
        Syslog.debug { Z3.Context().name }
    }
}
