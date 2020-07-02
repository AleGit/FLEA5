import XCTest
@testable import Base

class StringTests: ATestCase {
    let s0 =
            """
            Hello, Earth!

            I nearly was infected by humans!

            Yours
            Moon
            """
    let s1 = ["Venus", "Earth", "Mars"]
    let s2 = ["Hello", "Earth", "Yours", "Moon"]
    let s3 = ["Good", "Morning", "Sunshine"]

    let s4 =
            """


                Good Morning Sunshine       



            """

    func testTrimmingWhitespace() {
        XCTAssertEqual(s0, s0.trimmingWhitespace)
        XCTAssertEqual("Good Morning Sunshine", s4.trimmingWhitespace)

    }

    func testPealing() {
        XCTAssertEqual("", "".pealed)
        XCTAssertEqual("", "a".pealed)
        XCTAssertEqual("", "aa".pealed)
        XCTAssertEqual("a", "aaa".pealed)
        XCTAssertEqual("", "aaa".pealed.pealed)
        XCTAssertEqual("aa", "aaaa".pealed)
        XCTAssertEqual("", "aaaa".pealed.pealed)

        XCTAssertEqual("ab", "aaba".pealed.pealed)



    }

    func testContainsOne() {
        XCTAssertTrue(s0.containsOne(s1))
        XCTAssertTrue(s0.containsOne(s2))
        XCTAssertFalse(s0.containsOne(s3))

        XCTAssertFalse(s4.containsOne(s1))
        XCTAssertFalse(s4.containsOne(s2))
        XCTAssertTrue(s4.containsOne(s3))
    }

    func testContainsAll() {
        XCTAssertFalse(s0.containsAll(s1))
        XCTAssertTrue(s0.containsAll(s2))
        XCTAssertFalse(s0.containsAll(s3))

        XCTAssertFalse(s4.containsAll(s1))
        XCTAssertFalse(s4.containsAll(s2))
        XCTAssertTrue(s4.containsAll(s3))
    }
}
