#if os(OSX)
    import Darwin
#elseif os(Linux)
    import Glibc
#endif

import Foundation

import XCTest

@testable import Runtime

public class SyslogTests: XCTestCase {
    /// set up logging once _before_ all tests of a test class
    public override class func setUp() {
        super.setUp()
        Syslog.openLog(options: .console, .pid, .perror)
        Syslog.carping = false // off by default
    }

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {
        Syslog.closeLog()
        super.tearDown()
    }

    func testError() {

        XCTAssertEqual(Syslog.minimalLogLevel, .error)
        XCTAssertEqual(Syslog.maximalLogLevel, .notice)

        XCTAssertEqual(Syslog.defaultLogLevel, .notice)
        XCTAssertEqual(Syslog.logLevel(), .error)

    }

    func testWarning() {

        XCTAssertEqual(Syslog.minimalLogLevel, .error)
        XCTAssertEqual(Syslog.maximalLogLevel, .notice)

        XCTAssertEqual(Syslog.defaultLogLevel, .notice)
        XCTAssertEqual(Syslog.logLevel(), .warning)
    }

    func testMultiple() {

        XCTAssertEqual(Syslog.minimalLogLevel, .error)
        XCTAssertEqual(Syslog.maximalLogLevel, .notice)

        XCTAssertEqual(Syslog.defaultLogLevel, .notice)
        XCTAssertEqual(Syslog.logLevel(), .notice)

        // create new error and log it
        let newerror = open("/fictitious_file", O_RDONLY, 0) // sets errno to ENOENT

        Syslog.multiple(errcode: newerror) { "min=\(Syslog.minimalLogLevel) max=\(Syslog.maximalLogLevel) default=\(Syslog.defaultLogLevel)" }
    }
}
