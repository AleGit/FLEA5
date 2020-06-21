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

protocol HasSolver {
    var solver: Solver { get }
}

extension HasSolver where Self: AbstractTestCase {

}

public class Y2TestCase: AbstractTestCase {

    public override class func setUp() {
        super.setUp()
        yices_init()
    }

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {
        yices_exit()
        super.tearDown()
    }

}

public class Z3TestCase: AbstractTestCase { }