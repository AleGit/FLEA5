import Base
import Solver
import XCTest

class Z3ContextPublicTests: Z3TestCase {

  func testVersion() {
    #if os(macOS)
    let expected = "Z3 • 4.8.10.0"
    #else
    let expected = "Z3 • 4.8.9.0"
    #endif
    let actual = Z3.Context().description

    Syslog.notice { actual }
    XCTAssertEqual(expected, actual)
    Syslog.debug { Z3.Context().name }
  }
}
