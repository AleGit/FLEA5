import XCTest
import Foundation
@testable import Runtime

final class CommandLineTests: TestCase {
    func testName() {
        XCTAssertEqual(
            "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest", 
            CommandLine.name)
    }
}