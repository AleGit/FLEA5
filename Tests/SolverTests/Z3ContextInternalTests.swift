import XCTest
import Base
@testable import Solver

final class Z3ContextInternalTests: Z3TestCase {


    func _testDeMorgan() {
        let context = Z3.Context()
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

        XCTAssertNil( Z3.Model(context: context) )
    }
}
