import XCTest
import Utile

class CollectionTests: AbstractTestCase {
    func testArrayDecomposing() {
        let list1 = [1, 2, 3]
        guard let (head1, tail1) = list1.decomposing else {
            XCTFail()
            return
        }
        XCTAssertEqual(1, head1)
        XCTAssertEqual([2, 3], tail1)

        guard let (head2, tail2) = tail1.decomposing else {
            XCTFail()
            return
        }
        XCTAssertEqual(2, head2)
        XCTAssertEqual([3], tail2)

        guard let (head3, tail3) = tail2.decomposing else {
            XCTFail()
            return
        }
        XCTAssertEqual(3, head3)
        XCTAssertEqual([], tail3)
        XCTAssertEqual("Int", "\(type(of: head3))")
        XCTAssertEqual("ArraySlice<Int>", "\(type(of: tail3))")

        XCTAssertNil(tail3.decomposing)
    }

    func testStringDecomposing() {
        let string = "1👩‍👧‍👧3"
        guard let (head1, tail1) = string.decomposing else {
            XCTFail()
            return
        }
        XCTAssertEqual("1", head1)
        XCTAssertEqual("👩‍👧‍👧3", tail1)

        guard let (head2, tail2) = tail1.decomposing else {
            XCTFail()
            return
        }
        XCTAssertEqual("👩‍👧‍👧", head2)
        XCTAssertEqual("3", tail2)

        guard let (head3, tail3) = tail2.decomposing else {
            XCTFail()
            return
        }
        XCTAssertEqual("3", head3)
        XCTAssertEqual("", tail3)
        XCTAssertEqual("Character", "\(type(of: head3))")
        XCTAssertEqual("Substring", "\(type(of: tail3))")

        XCTAssertNil(tail3.decomposing)
    }
}