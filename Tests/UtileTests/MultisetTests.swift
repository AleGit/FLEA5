import XCTest
@testable import Utile

class MultisetTests : ATestCase {

    func testBasics() {
        var multiSet = MultiSet<Int>()
        let counts = [4,7,2,200,54,2,0,13,300,1]
        let sum = counts.reduce(0) { (a,b) in a+b }

        var counter = 0
        for (index, count) in counts.enumerated() {
            counter += count
            multiSet.insert(index, occurrences: count)
            XCTAssertEqual(count, multiSet.count(index))
        }
        XCTAssertEqual(counter, multiSet.count)
        XCTAssertEqual(sum, multiSet.count)

        let sum1 = counts.reduce(0) { (a,b) in a+max(b-1,0) }
        for (index, occurs) in counts.enumerated() {
            XCTAssertEqual(occurs, multiSet.count(index))
            multiSet.remove(index)
            XCTAssertEqual(max(0, occurs - 1), multiSet.count(index))
        }
        XCTAssertEqual(sum1, multiSet.count)

        let sum2 = counts.reduce(0) { (a,b) in a+max(b,1) }
        for (index, occurs) in counts.enumerated() {
            multiSet.insert(index)
            XCTAssertEqual(max(occurs,1), multiSet.count(index), "\(index)")
        }
        XCTAssertEqual(sum2, multiSet.count)

        for (index, occurs) in counts.enumerated() {
            multiSet.removeAllOf(index)
            XCTAssertEqual(0, multiSet.count(index))
        }
    }
}
