import XCTest
import Foundation
@testable import Base

final class CommandLineTests: ATestCase {
    func testName() {
        XCTAssertEqual(
            "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest", 
            CommandLine.name)
    }
}