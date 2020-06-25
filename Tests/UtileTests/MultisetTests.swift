import XCTest
@testable import Utile


class MultisetTests : ATestCase {

    private func multiset(counts: [Int]) -> MultiSet<Int> {
        var multiSet = MultiSet<Int>()
        var counter = 0
        for (index, count) in counts.enumerated() {
            counter += count
            multiSet.insert(index, occurrences: count)
            XCTAssertEqual(count, multiSet.count(index))
        }
        XCTAssertEqual(counter, multiSet.count)
        return multiSet

    }

    func testBasics() {

        let counts = [4, 7, 2, 200, 54, 2, 0, 13, 300, 1]
        let sum = counts.reduce(0) { (a, b) in
            a + b
        }

        var multiSet = multiset(counts: counts)
        XCTAssertEqual(sum, multiSet.count)

        let sum1 = counts.reduce(0) { (a, b) in
            a + max(b - 1, 0)
        }
        for (index, occurs) in counts.enumerated() {
            XCTAssertEqual(occurs, multiSet.count(index))
            multiSet.remove(index)
            XCTAssertEqual(max(0, occurs - 1), multiSet.count(index))
        }
        XCTAssertEqual(sum1, multiSet.count)

        let sum2 = counts.reduce(0) { (a, b) in
            a + max(b, 1)
        }
        for (index, occurs) in counts.enumerated() {
            multiSet.insert(index)
            XCTAssertEqual(max(occurs, 1), multiSet.count(index), "\(index)")
        }
        XCTAssertEqual(sum2, multiSet.count)

        for (index, occurs) in counts.enumerated() {
            multiSet.removeAllOf(index)
            XCTAssertEqual(0, multiSet.count(index))
        }
    }

}

extension MultisetTests {
    func testInitWithTuples() {
        let d = [("a", 20), ("b", 13), ("c",254), ("d", 1)]
        let multiSet = MultiSet(d)
        XCTAssertEqual(20, multiSet.count("a"))
        XCTAssertEqual(13, multiSet.count("b"))
        XCTAssertEqual(254 , multiSet.count("c"))
        XCTAssertEqual(1 , multiSet.count("d"))
        XCTAssertEqual(0 , multiSet.count("e"))
    }

    func testInitWithDictionary() {
        let d = ["a" : 20, "b" : 13, "c" : 254, "d" : 1]
        let multiSet = MultiSet(d)
        XCTAssertEqual(d["a"], multiSet.count("a"))
        XCTAssertEqual(d["b"], multiSet.count("b"))
        XCTAssertEqual(d["c"] , multiSet.count("c"))
        XCTAssertEqual(d["d"] , multiSet.count("d"))
        XCTAssertEqual(0 , multiSet.count("e"))
    }
}

extension MultisetTests {
    func testCustomStringConvertible() {
        let multiSet = ["a", "b", "c", "a", "c", "a"] as MultiSet<String>
        XCTAssertEqual("[a, a, a, b, c, c]", multiSet.description)

    }

    func testExpressibleByArrayLiteral() {
        let multiSet = ["a", "b", "c", "a", "c", "a"] as MultiSet<String>
        XCTAssertEqual(3, multiSet.count("a"))
        XCTAssertEqual(1, multiSet.count("b"))
        XCTAssertEqual(2, multiSet.count("c"))
    }

    func testExpressibleByDictionaryLiteral() {
        let multiSet = ["a" : 2, "b" : 3, "c" : 4, "a" : 5, "c" : 6, "a" : 1] as MultiSet<String>
        XCTAssertEqual(8, multiSet.count("a"))
        XCTAssertEqual(3, multiSet.count("b"))
        XCTAssertEqual(10, multiSet.count("c"))
    }

    func testEquatable() {
        let counts = [4, 72, 2, 9, 3, 5, 1, 22, 33]
        let expected = multiset(counts: counts)

        var elements = [Int]()
        for (index, occurs) in counts.enumerated() {
            for i in 0..<occurs {
                elements.append(index)
            }
        }
        elements.shuffle()

        XCTAssertEqual(expected, MultiSet(elements))

        var actual = MultiSet<Int>()
        for element in elements {
            XCTAssertNotEqual(expected, actual)
            actual.insert(element)
        }
        XCTAssertEqual(expected, actual)

        actual.remove(3)
        XCTAssertNotEqual(expected, actual)
        actual.insert(3, occurrences: 3)
        XCTAssertNotEqual(expected, actual)
        actual.remove(3, occurrences: 2)
        XCTAssertEqual(expected, actual)
    }
}
