import Foundation
import XCTest
import CYices

import Runtime
@testable import Solver

public class TestCase: XCTestCase {

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
}

protocol HasSolver {
    var solver: Solver { get }
}

extension HasSolver where Self: TestCase {

}

public class Y2TestCase: TestCase {

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

public class Z3TestCase: TestCase { }