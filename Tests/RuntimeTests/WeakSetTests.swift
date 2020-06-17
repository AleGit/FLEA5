import XCTest
@testable import Runtime

class WeakSetTests : XCTestCase {
    class Simple : Hashable, CustomStringConvertible{
        let name : String

        init(name: String) {
            self.name = name
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(self.name)

        }

        static func ==(lhs: Simple, rhs: Simple) -> Bool {
            lhs.name == rhs.name
        }

        var description: String {
             return self.name
        }
    }

    func testUseCase() {

        var a : Simple? = Simple(name: "a")
        var b : Simple? = Simple(name: "b")
        var c : Simple? = Simple(name: "c")

        var w = WeakSet<Simple>()

        w.insert(a!)
        w.insert(b!)
        w.insert(c!)

        XCTAssertEqual(3, w.count)
        XCTAssertEqual(0, w.nilCount)
        XCTAssertEqual(w.count + w.nilCount, w.totalCount)
        XCTAssertTrue(w.totalCount >= w.keyCount)


        w.insert(Simple(name:"d"))
        XCTAssertEqual(0, w.collisionCount)
        XCTAssertEqual(3, w.count)
        XCTAssertEqual(1, w.nilCount)
        XCTAssertEqual(w.count + w.nilCount, w.totalCount)
        XCTAssertTrue(w.totalCount >= w.keyCount)

        a = nil
        XCTAssertEqual(0, w.collisionCount)
        XCTAssertEqual(2, w.count)
        XCTAssertEqual(2, w.nilCount)
        XCTAssertEqual(w.count + w.nilCount, w.totalCount)
        XCTAssertTrue(w.totalCount >= w.keyCount)

        w.clean()
        XCTAssertEqual(0, w.collisionCount)
        XCTAssertEqual(2, w.count)
        XCTAssertEqual(0, w.nilCount)
        XCTAssertEqual(w.count + w.nilCount, w.totalCount)
        XCTAssertTrue(w.totalCount >= w.keyCount)


        b = nil
        XCTAssertEqual(0, w.collisionCount)
        XCTAssertEqual(1, w.count)
        c = nil

        XCTAssertEqual(0, w.collisionCount)
        XCTAssertEqual(0, w.count)
        



    }

}
