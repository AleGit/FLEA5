import XCTest
import Foundation
@testable import Auxiliary

final class CommandLineTests: XCTestCase {
    func testName() {
        XCTAssertEqual(
            "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest", 
            CommandLine.name)
    }
}