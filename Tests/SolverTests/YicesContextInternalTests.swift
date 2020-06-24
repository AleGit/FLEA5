import XCTest
import Base
import CYices
@testable import Solver

class YicesContextInternalTests: YicesTestCase {

    func testDeMorgan() {
        let context = createContext()
        let x = context.declare(proposition: "x")
        let y = context.declare(proposition: "y")
        let not_x = context.negate(formula: x)
        let not_y = context.negate(formula: y)

        let x_and_y = context.formula(x, and: y)
        let ls = context.negate(formula: x_and_y)
        let rs = context.formula(not_x, or: not_y)
        let de_morgan = context.formula(ls, iff: rs)
        let negated = context.negate(formula: de_morgan)

        context.assert(formula: negated)

        XCTAssertFalse(context.isSatisfiable)
        XCTAssertNil(context.model)
    }

    func testPfa() {
        let context = createContext()

        let a = context.declare(constant: "a")
        let f = context.declare(function: "f", arity: 1)
        let fa = context.apply(function: f, args: [a])
        let p = context.declare(predicate: "p", arity: 1)
        let pfa = context.apply(predicate: p, args: [fa])

        let not = context.negate(formula: pfa)
        let top = context.formula(pfa, or: not)

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

    func testConjunction() {
        let context = createContext()
        let a = context.declare(proposition: "a")
        let b = context.declare(proposition: "b")
        let c = context.declare(proposition: "c")

        let na = context.negate(formula: a)
        let nb = context.negate(formula: b)
        let nc = context.negate(formula: c)

        context.assert(formula: context.conjunct(formulae: a,b,c))
        XCTAssertTrue(context.isSatisfiable)

        context.assert(formula: context.conjunct(formulae: na,nb,nc))
        XCTAssertFalse(context.isSatisfiable)
    }

    func testDisjunction() {
        let context = createContext()
        let a = context.declare(proposition: "a")
        let b = context.declare(proposition: "b")
        let c = context.declare(proposition: "c")

        let na = context.negate(formula: a)
        let nb = context.negate(formula: b)
        let nc = context.negate(formula: c)

        context.assert(formula: context.disjunct(formulae: a,b,c))
        XCTAssertTrue(context.isSatisfiable)

        context.assert(formula:context.disjunct(formulae: na,nb,nc))
        XCTAssertTrue(context.isSatisfiable)

        context.assert(formula: context.disjunct(formulae: nb, c))
        XCTAssertTrue(context.isSatisfiable)

        context.assert(formula: context.disjunct(formulae: na, c))
        XCTAssertTrue(context.isSatisfiable)

        context.assert(formula: context.disjunct(formulae: b, nc))
        XCTAssertTrue(context.isSatisfiable)

        context.assert(formula: context.disjunct(formulae: a, nc))
        XCTAssertFalse(context.isSatisfiable)
    }
}
