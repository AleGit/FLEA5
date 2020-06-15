//
// Created by Alexander Maringele on 15.06.20.
//

import Foundation
import XCTest

@testable import Solver

class YicesTests: XCTestCase {
    // setup yices before all tests
    public override class func setUp() {
        print("\(#file).\(#function)")
        super.setUp()
        Yices.setUp()
}

    /// teardown yices after all tests
    override class func tearDown() {
        print("\(#file).\(#function)")
        Yices.tearDown()
        super.tearDown()
    }

    func testVersion() {
        print("\(#file).\(#function)")
        XCTAssertEqual(Yices.versionString, "2.6.2")
        XCTAssertEqual(Yices.version, [2,6,2])
    }

    func testError() {
        print("\(#file).\(#function)")
        XCTAssertEqual(Yices.errorString, "no error")
    }
}
