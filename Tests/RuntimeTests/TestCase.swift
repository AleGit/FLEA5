import Foundation
import XCTest

@testable import Runtime

public class TestCase: XCTestCase {
    /// set up logging once _before_ all tests of a test class
    public override class func setUp() {
        super.setUp()
        Syslog.openLog(options: .console, .pid, .perror, verbosely: true)
        Syslog.carping = false // off by default
    }

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {
        Syslog.closeLog()
        super.tearDown()
    }

}