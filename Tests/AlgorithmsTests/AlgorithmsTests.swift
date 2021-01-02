import Algorithms
import XCTest

class AlgorithmsTest: ATestCase {

  public func testCombinations() {
    let input: Set = [2, 3, 5, 7]

    XCTAssertEqual(1, input.combinations(ofCount: 0).count)
    XCTAssertEqual(4, input.combinations(ofCount: 1).count)
    XCTAssertEqual(6, input.combinations(ofCount: 2).count)
    XCTAssertEqual(4, input.combinations(ofCount: 3).count)
    XCTAssertEqual(1, input.combinations(ofCount: 4).count)
    XCTAssertEqual(0, input.combinations(ofCount: 5).count)

  }

  public func testPermutations() {
    let input: Set = [2, 3, 5, 7]

    XCTAssertEqual(1, input.permutations(ofCount: 0).count)
    XCTAssertEqual(4, input.permutations(ofCount: 1).count)
    XCTAssertEqual(4 * 3, input.permutations(ofCount: 2).count)
    XCTAssertEqual(4 * 3 * 2, input.permutations(ofCount: 3).count)
    XCTAssertEqual(4 * 3 * 2 * 1, input.permutations(ofCount: 4).count)
    XCTAssertEqual(0, input.permutations(ofCount: 5).count)

  }
}
