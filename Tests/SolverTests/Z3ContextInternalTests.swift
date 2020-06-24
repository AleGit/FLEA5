import XCTest
import Base
@testable import Solver

final class Z3ContextInternalTests: Z3TestCase {

    func testDeMorgan() {
        let context = Z3.Context()
        let x = context.declare(proposition: "px")
        let y = context.declare(proposition: "py")
        let not_x = context.negate(formula: x)
        let not_y = context.negate(formula: y)

        let x_and_y = context.and(lhs: x, rhs: y)
        let ls = context.negate(formula: x_and_y)
        let rs = context.or(lhs: not_x, rhs: not_y)
        let de_morgan = context.iff(lhs: ls, rhs: rs)
        let negated = context.negate(formula: de_morgan)

        context.assert(formula: negated)

        XCTAssertFalse(context.isSatisfiable)
        XCTAssertNil(context.model)
    }

    func testPfa() {
        let context = Z3.Context()

        let a = context.declare(constant: "a")
        let f = context.declare(function: "f", arity: 1)
        let fa = context.apply(term: f, args: [a])
        let p = context.declare(predicate: "p", arity: 1)
        let pfa = context.apply(term: p, args: [fa])

        let not = context.negate(formula: pfa)
        let top = context.or(lhs: pfa, rhs: not)

        context.assert(formula: top)
        XCTAssertTrue(context.isSatisfiable)
        var model = context.model!

        XCTAssertTrue(model.satisfies(formula: top) == true)
        XCTAssertTrue(model.satisfies(formula: pfa) == nil)
        XCTAssertTrue(model.satisfies(formula: not) == nil)

        context.assert(formula: pfa)
        XCTAssertTrue(context.isSatisfiable)
        model = context.model!
        XCTAssertNotNil(model)

        XCTAssertTrue(model.satisfies(formula: top) == true)
        XCTAssertTrue(model.satisfies(formula: pfa) == true)
        XCTAssertTrue(model.satisfies(formula: not) == false)

        context.assert(formula: not)
        XCTAssertFalse(context.isSatisfiable)
        XCTAssertNil(context.model)


    }
}
