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

    func testComposition() {
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
                                    XCTAssertEqual(l.first?.key, m.first?.key)
                                    break
                                }

                                guard let mr = m * r else {
                                    XCTAssertEqual(m.first?.key, r.first?.key)
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


