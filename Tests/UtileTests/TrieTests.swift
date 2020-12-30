import Base
import XCTest

@testable import Utile

class TrieTests: ATestCase {
  lazy var pathA = [1, 4, 5, 6, 7, 8]
  lazy var valueA = "A"
  lazy var pathB = [1, 4, 5, 6, 1]
  lazy var valueB = "B"

  func testTrieStruct() {
    typealias T = TrieStruct

    let (_, triple) = Time.measure { () -> Void in

      var mytrie1 = T<Int, String>()
      var mytrie2 = T(with: valueA, at: pathA)

      XCTAssertTrue(mytrie1.isEmpty, nok)
      mytrie1.insert(valueA, at: pathA)
      XCTAssertEqual(mytrie1, mytrie2, nok)

      mytrie1.insert(valueB, at: pathB)
      mytrie2.insert(valueB, at: pathB)
      XCTAssertEqual(mytrie1, mytrie2, nok)

      let values: Set = [valueA, valueB]
      XCTAssertEqual(values, mytrie1.allValues, nok)

      // remove values from wrong path
      XCTAssertNil(mytrie1.remove(valueA, at: pathB), nok)
      XCTAssertNil(mytrie1.remove(valueB, at: pathA), nok)

      // remove value a from path a
      XCTAssertEqual(valueA, mytrie1.remove(valueA, at: pathA), nok)
      XCTAssertFalse(mytrie1.isEmpty, nok)

      // remove value b from path b
      XCTAssertEqual(valueB, mytrie1.remove(valueB, at: pathB), nok)
      XCTAssertTrue(mytrie1.isEmpty, nok)

      XCTAssertEqual(mytrie2.retrieve(from: pathA)!, Set([valueA]))
      XCTAssertEqual(mytrie2.retrieve(from: pathB)!, Set([valueB]))
      XCTAssertEqual(mytrie2.retrieve(from: [Int]())!, Set<String>())

      XCTAssertEqual(mytrie2.retrieve(from: [1])!, Set<String>())
      XCTAssertNil(mytrie2.retrieve(from: [2]))
    }

    print(ok, triple)

  }

  func testTrieClass() {
    typealias T = TrieClass

    let (_, triple) = Time.measure { () -> Void in

      var mytrie1 = T<Int, String>()
      var mytrie2 = T(with: valueA, at: pathA)

      XCTAssertTrue(mytrie1.isEmpty, nok)
      mytrie1.insert(valueA, at: pathA)
      XCTAssertEqual(mytrie1, mytrie2, nok)

      mytrie1.insert(valueB, at: pathB)
      mytrie2.insert(valueB, at: pathB)
      XCTAssertEqual(mytrie1, mytrie2, nok)

      let values: Set = [valueA, valueB]
      XCTAssertEqual(values, mytrie1.allValues, nok)

      // remove values from wrong path
      XCTAssertNil(mytrie1.remove(valueA, at: pathB), nok)
      XCTAssertNil(mytrie1.remove(valueB, at: pathA), nok)

      // remove value a from path a
      XCTAssertEqual(valueA, mytrie1.remove(valueA, at: pathA), nok)
      XCTAssertFalse(mytrie1.isEmpty, nok)

      // remove value b from path b
      XCTAssertEqual(valueB, mytrie1.remove(valueB, at: pathB), nok)
      XCTAssertTrue(mytrie1.isEmpty, nok)

      XCTAssertEqual(mytrie2.retrieve(from: pathA)!, Set([valueA]))
      XCTAssertEqual(mytrie2.retrieve(from: pathB)!, Set([valueB]))
      XCTAssertEqual(mytrie2.retrieve(from: [Int]())!, Set<String>())

      XCTAssertEqual(mytrie2.retrieve(from: [1])!, Set<String>())
      XCTAssertNil(mytrie2.retrieve(from: [2]))
    }

    print(ok, triple)

  }
}
