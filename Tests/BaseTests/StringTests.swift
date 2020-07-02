import XCTest
@testable import Base

class StringTests: ATestCase {
    let string =
            """
            Hello, Earth!

            I nearly was infected by humans!

            Yours
            Moon
            """
    let s1 = ["Venus", "Earth", "Mars"]
    let s2 = ["Hello", "Earth", "Yours", "Moon"]
    let s3 = ["Good", "Morning", "Sunshine"]

    func testTrimmingWhitespace() {

    }

    func testPealing() {

    }

    func testContainsOne() {
        XCTAssertTrue(string.containsOne(s1))
        XCTAssertTrue(string.containsOne(s2))
        XCTAssertFalse(string.containsOne(s3))
    }

    func testContainsAll() {
        XCTAssertFalse(string.containsAll(s1))
        XCTAssertTrue(string.containsAll(s2))
        XCTAssertFalse(string.containsAll(s3))

    }
}
