#if os(OSX)
    import Darwin
#elseif os(Linux)
    import Glibc
#endif

import Foundation

import XCTest

@testable import Runtime

public class SyslogTests: FleaTestCase {
    // static var allTests: [(String, (SyslogTests) -> () throws -> Void)] {
    //     return [
    //         ("testSyslog", testSyslog),
    //         ("testConfiguration", testConfiguration),
    //     ]
    // }

    // func syslog(priority : Int32, _ message : String, _ args : CVarArg...) {
    //   withVaList(args) { vsyslog(priority, message, $0) }
    // }

    /// [syslog](https://en.wikipedia.org/wiki/Syslog) wrapper demo.
    /// Messages should appear near the output of the test,
    public override func setUp() {
        super.setUp()
        // Put setUp code here. This method is called before the invocation of each test method in the class.
        // Syslog.openLog(ident:"ABC", options:.console,.pid,.perror)
        _ = Syslog.setLogMask(upTo: .debug)
    }

    public override func tearDown() {

        // Syslog.closeLog()
        // Put tearDown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSyslog() {
        // create new error and log it
        let newerror = open("/fictitious_file", O_RDONLY, 0) // sets errno to ENOENT

        Syslog.multiple(errcode: newerror) { "min=\(Syslog.minimalLogLevel) max=\(Syslog.maximalLogLevel) default=\(Syslog.defaultLogLevel)" }
    }

    func testTestConfiguration() {

        XCTAssertEqual(Syslog.minimalLogLevel, .error)
        XCTAssertEqual(Syslog.maximalLogLevel, .notice)

        // emergency < alert < critical < error < warning < notice < info < debug

        XCTAssertEqual(Syslog.defaultLogLevel, .info)
    }

    // func testConfiguration() {
    //     let path = "Configs/default.logging"

    //     guard let allLines = path.lines(), allLines.count > 15 else {
    //         XCTFail()
    //         return
    //     }

    //     guard let lines = path.lines(predicate: {
    //         !($0.hasPrefix("#") || $0.isEmpty)
    //     }), lines.count == 6 else {
    //         XCTFail()
    //         return
    //     }

    //     XCTAssertTrue(allLines.count > lines.count)
    // }
}
