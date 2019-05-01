import XCTest
import Foundation
@testable import Runtime

final class CommandLineTests: XCTestCase {
    private func show(file: String = #file, function: String = #function) {
        print("😀", file, function)
    }

    private var bar: String {
        get { 
            show()
            return "x";  
            }
        set { show() }
    }

    private func foo() -> Void {
        show()
    }

    private func foo(a: String, b: Int) -> Void {
        show()
    }

    private func foo(_ a: String, _ b: Int) -> Void {
        show()
    }

    private func foo(x: String = "hi", _ y: Int = 0) -> Void {
        show()
    }

    func testName() {
        XCTAssertEqual(
            "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest", 
            CommandLine.name)
        show()
        self.bar = "ach"
        _ = self.bar

        foo()
        foo(a:"H", b:3)
        foo("X", 4)
        foo(3)
    }
}