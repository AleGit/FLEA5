import CZ3Api
import XCTest

/// https://github.com/Z3Prover/z3/blob/master/examples/c/test_capi.c
class CZ3ApiTests: XCTestCase {
    // setup yices before all tests
    public override class func setUp() {
    }

    /// teardown yices after all tests
    override class func tearDown() {
    }

    func testDeMorgan() {
        let cfg = Z3_mk_config()
        defer { Z3_del_config(cfg) }
        let ctx = Z3_mk_context(cfg)
        defer { Z3_del_context(ctx) }

        let bool_sort = Z3_mk_bool_sort(ctx)
        let symbol_x = Z3_mk_int_symbol(ctx, 0)
        let symbol_y = Z3_mk_int_symbol(ctx, 1)
        let x = Z3_mk_const(ctx, symbol_x, bool_sort)
        let y = Z3_mk_const(ctx, symbol_y, bool_sort)

        /* De Morgan - with a negation around */
        /* !(!(x && y) <-> (!x || !y)) */
        let not_x              = Z3_mk_not(ctx, x)
        let not_y              = Z3_mk_not(ctx, y)

        let x_and_y            = Z3_mk_and(ctx, 2, [ x, y ]);
        let ls                 = Z3_mk_not(ctx, x_and_y);
        let rs                 = Z3_mk_or(ctx, 2, [not_x, not_y]);
        let conjecture         = Z3_mk_iff(ctx, ls, rs);
        let negated_conjecture = Z3_mk_not(ctx, conjecture);

        let s = Z3_mk_solver(ctx)
        Z3_solver_inc_ref(ctx, s)
        defer { Z3_solver_dec_ref(ctx, s) }

        Z3_solver_assert(ctx, s, negated_conjecture)
        let result = Z3_solver_check(ctx, s)

        XCTAssertEqual(result, Z3_L_FALSE, "De Morgan is not valid.")

    }
}
