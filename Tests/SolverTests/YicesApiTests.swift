import CYices
import XCTest
import Base

class YicesApiTests: Y2TestCase {

    func testDeMorgan() {
        let ctx = yices_new_context(nil)
        defer { yices_free_context(ctx) }

        let bool_sort = yices_bool_type()

        let x = yices_new_uninterpreted_term(bool_sort)
        let y = yices_new_uninterpreted_term(bool_sort)
        yices_set_term_name(x, "x")
        yices_set_term_name(y, "y")

        /* De Morgan - with a negation around */
        /* !(!(x && y) <-> (!x || !y)) */
        let not_x = yices_not(x)
        let not_y = yices_not(y)

        let x_and_y = yices_and2(x,y)
        let ls = yices_not(x_and_y)
        let rs = yices_or2(not_x, not_y)
        let de_morgan = yices_iff(ls, rs)
        let negated_de_morgan = yices_not(de_morgan)

        let result = yices_check_formula(negated_de_morgan, nil, nil, nil)
        XCTAssertEqual(result, STATUS_UNSAT, "De Morgan is not valid.")

        yices_assert_formula(ctx, negated_de_morgan)
        let status = yices_check_context(ctx, nil)
        
        XCTAssertEqual(status, STATUS_UNSAT, "De Morgan is not valid.")

        let model = yices_get_model(ctx, 1)
        // defer { yices_free_model(model) }
        XCTAssertNil(model)
    }

    func testPfa() {
        let ctx = yices_new_context(nil)
        defer {
            yices_free_context(ctx)
        }

        print(type(of: ctx))

        let bool_tau: type_t = yices_bool_type()
        let free_tau: type_t = yices_new_uninterpreted_type()
        yices_set_type_name(free_tau, "τ")

        let a: term_t = yices_new_uninterpreted_term(free_tau)
        yices_set_term_name(a, "a")

        let f_sort: type_t = yices_function_type(1, [free_tau], free_tau) // unary function symbol
        let f = yices_new_uninterpreted_term(f_sort)
        yices_set_type_name(f, "f")
        let fa: term_t = yices_application(f, 1, [a])

        let p_sort: type_t = yices_function_type(1, [free_tau], bool_tau) // unary predicate symbol
        let p: term_t = yices_new_uninterpreted_term(p_sort)
        yices_set_term_name(p, "p")
        let pfa: term_t = yices_application(p, 1, [fa])

        let negation = yices_not(pfa)
        let tautology = yices_or2(pfa, negation)
        let contradiction = yices_and2(pfa, negation)

        yices_assert_formula(ctx, tautology)

        XCTAssertEqual(STATUS_SAT, yices_check_context(ctx, nil))

        guard let model = yices_get_model(ctx, 1) else {
            XCTFail()
            return
        }
        defer {
            yices_free_model(model)
        }

        XCTAssertEqual(yices_formula_true_in_model(model, tautology), 1)
        XCTAssertEqual(yices_formula_true_in_model(model, pfa), 0)
        XCTAssertEqual(yices_formula_true_in_model(model, negation), 1)

        yices_assert_formula(ctx, contradiction)
        XCTAssertEqual(STATUS_UNSAT, yices_check_context(ctx, nil))
    }
}
