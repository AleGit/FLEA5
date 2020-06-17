import CYices
import XCTest
import Runtime

class Y2ApiTests: Y2TestCase {

    func testDeMorgan() {
        Syslog.notice { "De Morgan"}
//        let cfg = yices_new_config()
//        defer { yices_free_config(cfg)}
//
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
        let conjecture = yices_iff(ls, rs)
        let negated_conjecture = yices_not(conjecture)

        let result = yices_check_formula(negated_conjecture, nil, nil, nil)
        XCTAssertEqual(result, STATUS_UNSAT, "De Morgan is not valid.")

        yices_assert_formula(ctx, negated_conjecture)
        let status = yices_check_context(ctx, nil)
        
        XCTAssertEqual(status, STATUS_UNSAT, "De Morgan is not valid.")
    }
}
