import XCTest
import Foundation
@testable import Base

final class CommandLineTests: AbstractTestCase {
    func testName() {
        XCTAssertEqual(
            "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest", 
            CommandLine.name)
    }
}