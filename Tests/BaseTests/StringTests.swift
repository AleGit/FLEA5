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
        for s in ["a", "(a)", "([a])", "([{a}])", 
                  "\"([a])\"", "|\"([a])\"|", "'|\"([a])\"|'", "<'|\"([a])\"|'>"] {
            XCTAssertEqual("a", s.peeled())
            XCTAssertEqual(s.peeled(), s.peeled().peeled())

            XCTAssertEqual("", s.replacingOccurrences(of: "a", with: "").peeled())
        }

        for s in ["a", ")a)", "([a](", "([{a}]|",
                  "'([a])\"", "|\"([a])\"'", "(|\"([a])\"|'", "<'|\"([a])\"|')"] {
            XCTAssertEqual(s, s.peeled())
            XCTAssertEqual(s.peeled(), s.peeled().peeled())
        }
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
