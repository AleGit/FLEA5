import XCTest
import Base
import CYices
@testable import Solver

class YicesContextInternalTests: YicesTestCase {

    func testDeMorgan() {
        let context = Yices.Context()
        let x = context.declare(proposition: "x")
        let y = context.declare(proposition: "y")
        let not_x = context.negate(term: x)
        let not_y = context.negate(term: y)

        let x_and_y = context.and(lhs: x, rhs: y)
        let ls = context.negate(term: x_and_y)
        let rs = context.or(lhs: not_x, rhs: not_y)
        let de_morgan = context.iff(lhs: ls, rhs: rs)
        let negated = context.negate(term: de_morgan)

        context.assert(formula: negated)

        XCTAssertNil( Yices.Model(context: context) )
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
