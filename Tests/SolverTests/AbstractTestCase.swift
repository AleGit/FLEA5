import XCTest
import Base
import CYices
@testable import Solver

public class AbstractTestCase: XCTestCase {

    /// set up logging once _before_ all tests of a test class
    public override class func setUp() {
        super.setUp()
        Syslog.openLog(options: .console, .pid, .perror, verbosely: false)
    }

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {
        Syslog.closeLog()
        super.tearDown()
    }

    public func testTest() {
        print("*️⃣", type(of: self))
    }
}

public class Y2TestCase: AbstractTestCase {
    static var context : Yices.Context?

    public override class func setUp() {
        super.setUp()
        Y2TestCase.context = Yices.Context()
    }

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {
        Y2TestCase.context = nil
        super.tearDown()
    }

}

public class Z3TestCase: AbstractTestCase { }