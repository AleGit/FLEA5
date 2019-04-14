import XCTest
import Foundation
@testable import Runtime

final class CommandLineTests: FleaTestCase {
    func testName() {
        XCTAssertEqual(
            "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest", 
            CommandLine.name)
    }
}