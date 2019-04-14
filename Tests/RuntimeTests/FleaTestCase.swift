let ok = "✅ "
let nok = "❌ "

#if os(OSX)
    import Darwin
#elseif os(Linux)
    import Glibc
#endif

import Foundation
import XCTest

@testable import Runtime

public class FleaTestCase: XCTestCase {

    /// set up logging once _before_ all tests of a test class
    public override class func setUp() {
        super.setUp()
        Syslog.openLog(options: .console, .pid, .perror)
        let logLevel = Syslog.maximalLogLevel

        _ = Syslog.setLogMask(upTo: logLevel)
        print("+++ +++ FleaTestCase.\(#function) +++ \(#file) +++")
        Syslog.carping = false // off by default
    }

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {
        print("--- --- FleaTestCase.\(#function) --- \(#file) ---")
        Syslog.closeLog()
        super.tearDown()
    }
}