import XCTest
@testable import Utile

final class SubstitutionTests : ATestCase {

    func testIsHomogenous() {
        XCTAssertTrue(["a": "b"].isHomogenous)
        XCTAssertTrue([1: 1].isHomogenous)

        XCTAssertTrue([Int: Int]().isHomogenous)
        XCTAssertTrue([String: String]().isHomogenous)

        XCTAssertTrue([N: N]().isHomogenous)
    }

    func testIsNotHomogenous() {
        XCTAssertFalse(["a": 1].isHomogenous)
        XCTAssertFalse([1: "a"].isHomogenous)

        XCTAssertFalse([Int: String]().isHomogenous)
        XCTAssertFalse([String: Int]().isHomogenous)
    }

    func testSimpleComposition() {
        for li in [x,y,z] {
            for lj in [x,y,z] {
                for lk in [x,y,z] {
                    for ri in [x,y,z,a,b,c] {
                        for rj in [x,y,z,a,b,c] {
                            for rk in [x,y,z,a,b,c] {
                                let l = [li:ri]
                                let m = [lj:rj]
                                let r = [lk:rk]

                                guard let lm = l * m else {
                                    XCTAssertEqual(l.first?.key, m.first?.key, "\(l) \(m)")
                                    break
                                }

                                guard let mr = m * r else {
                                    XCTAssertEqual(m.first?.key, r.first?.key, "\(b) \(r)")
                                    break
                                }
                                XCTAssertEqual(lm * r, l * mr, "\(l) \(m) \(r)")
                            }
                        }
                    }
                }
            }
        }
    }

    func testCompositions() {
        XCTAssertEqual([x:a], [x:x] * [x: a])
        XCTAssertEqual([x:a], [x:a] * [x: a])

        XCTAssertEqual([x:x, y:x], [x:y] * [y: x])
        XCTAssertEqual([x:y, y:y], [y:x] * [x: y])

        XCTAssertEqual([x:a, y:a], [y:x] * [x:y] * [y:a])
        XCTAssertEqual([x:a, y:a], ([y:x] * [x:y]) * [y:a])
        XCTAssertEqual([x:a, y:a], [y:x] * ([x:y] * [y:a]))

        XCTAssertNil( [x:a] * [x:b] )
        XCTAssertNil( [x:a] * [x:x] )

    }

    func testApply() {
        let σ = [y: a]

        XCTAssertTrue(σ.isSubstitution)
        XCTAssertFalse(σ.isVariableSubstitution)

        for t in [a, y] {
            XCTAssertEqual(a, t * σ, t.description)
        }

        let faa = fxy * [x: a, y: a]
        let fay = fxy * [x: a]
        let fya = fxy * [x: y, y: a]
        let fyy = fxy * [x:y]

        for t in [faa, fay, fya, fyy] {
            XCTAssertEqual(faa, t * σ, t.description)
        }

    }
}


