import XCTest
import Base
import CYices
@testable import Solver

class Y2ContextTests: YicesTestCase {

    func testVersion() {
        let expected = "Yices2 • 2.6.2"
        let actual = Yices.Context().description

        Syslog.notice { actual }
        Syslog.debug { Yices.Context().name }
        XCTAssertEqual(expected, actual)
    }

    func testP() {
        let context = Yices.Context()
        let p = context.declare(proposition: "p")
        let q = context.declare(proposition: "q")
        let n = yices_not(p)
        let or = yices_or2(p, n)
        let nq = yices_and2(n, q)
        context.assert(formula: or)
        context.assert(formula: nq)
        let model = Yices.Model(context: context)
        XCTAssertTrue( model?.satisfies(formula: or) ?? false)
        XCTAssertTrue( model?.satisfies(formula: nq) ?? false)
        XCTAssertTrue( model?.satisfies(formula: n) ?? false)
        XCTAssertFalse( model?.satisfies(formula: p) ?? false)
        XCTAssertTrue( model?.satisfies(formula: q) ?? false)

    }

    func _testPfa() {
        let context = Yices.Context()

        let a = context.declare(constant: "a")
        let f = context.declare(function: "f", arity: 1)
        let fa = context.apply(term: f, args: [a])
        let p = context.declare(predicate: "p", arity: 1)
        let pfa = context.apply(term: p, args: [fa])

        let not = yices_not(pfa)
        let t = yices_or2(pfa, not)

        context.assert(formula: t)
        let model: Yices.Model! = Yices.Model(context: context)
        XCTAssertNotNil(model)

        XCTAssertTrue( model.satisfies(formula: t) ?? false)
        XCTAssertNotNil(model.satisfies(formula: pfa))
        XCTAssertNotNil(model.satisfies(formula: not))
        // XCTAssertNotEqual(model.satisfies(formula: pfa), model.satisfies(formula: not))
        XCTAssertTrue( model.satisfies(formula: pfa) == true)
        XCTAssertTrue( model.satisfies(formula: not) == true)

        /*
        context.assert(formula: pfa)

        model = Yices.Model(context: context) // 2nd model
        XCTAssertNotNil(model)

        XCTAssertTrue( model.satisfies(formula: top))
        XCTAssertTrue( model.satisfies(formula: pfa))
        XCTAssertFalse( model.satisfies(formula: not))

        context.assert(formula:not)

        XCTAssertNil(Yices.Model(context: context)) // no model
*/
    }
}
