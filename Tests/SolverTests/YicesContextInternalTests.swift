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

    func testPfa() {
        let context = Yices.Context()

        let a = context.declare(constant: "a")
        let f = context.declare(function: "f", arity: 1)
        let fa = context.apply(term: f, args: [a])
        let p = context.declare(predicate: "p", arity: 1)
        let pfa = context.apply(term: p, args: [fa])

        let not = context.negate(term: pfa)
        let top = context.or(lhs: pfa, rhs: not)

        context.assert(formula: top)
        var model: Yices.Model! = Yices.Model(context: context)
        XCTAssertNotNil(model)

        XCTAssertTrue(model.satisfies(formula: top) == true)
        XCTAssertTrue(model.satisfies(formula: pfa) == nil)
        XCTAssertTrue(model.satisfies(formula: not) == nil)

        context.assert(formula: pfa)
        model = Yices.Model(context: context)
        XCTAssertNotNil(model)

        XCTAssertTrue(model.satisfies(formula: top) == true)
        XCTAssertTrue(model.satisfies(formula: pfa) == true)
        XCTAssertTrue(model.satisfies(formula: not) == false)

        context.assert(formula: not)
        model = Yices.Model(context: context)
        XCTAssertNil(model)
    }
}
