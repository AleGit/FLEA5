import CZ3Api
import XCTest
import Base

/// https://github.com/Z3Prover/z3/blob/master/examples/c/test_capi.c
class Z3ApiTests: AbstractTestCase {

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
        let de_morgan = Z3_mk_iff(ctx, ls, rs);
        let negated_de_morgan = Z3_mk_not(ctx, de_morgan);

        let s = Z3_mk_solver(ctx)
        Z3_solver_inc_ref(ctx, s)
        defer { Z3_solver_dec_ref(ctx, s) }

        Z3_solver_assert(ctx, s, negated_de_morgan)
        let result = Z3_solver_check(ctx, s)

        XCTAssertEqual(result, Z3_L_FALSE, "De Morgan is not valid.")
    }

    func testPfa() {
        let cfg = Z3_mk_config()
        defer { Z3_del_config(cfg) }
        let ctx = Z3_mk_context(cfg)
        defer { Z3_del_context(ctx) }

        print(type(of: ctx))

        let tau_symbol = Z3_mk_string_symbol(ctx, "𝛕")
        let a_symbol = Z3_mk_string_symbol(ctx, "a")
        let f_symbol = Z3_mk_string_symbol(ctx, "f")
        let p_symbol = Z3_mk_string_symbol(ctx, "p")

        let bool_tau = Z3_mk_bool_sort(ctx)
        let free_tau = Z3_mk_uninterpreted_sort(ctx, tau_symbol)

        // let a = Z3_mk_func_decl(ctx, a_symbol, 0, nil, free_tau)
        let f = Z3_mk_func_decl(ctx, f_symbol, 1, [free_tau], free_tau)
        let p = Z3_mk_func_decl(ctx, p_symbol, 1, [free_tau], bool_tau)

        let a = Z3_mk_const(ctx, a_symbol, free_tau)
        let fa = Z3_mk_app(ctx, f, 1, [a])
        let pfa = Z3_mk_app(ctx, p, 1, [fa])

        let negation = Z3_mk_not(ctx, pfa)
        let tautology = Z3_mk_or(ctx, 2, [pfa, negation])
        let contradiction = Z3_mk_and(ctx, 2, [pfa, negation])

        let s = Z3_mk_solver(ctx)
        Z3_solver_assert(ctx, s, tautology)
        XCTAssertEqual(Z3_solver_check(ctx, s), Z3_L_TRUE)
        Z3_solver_assert(ctx, s, pfa)
        XCTAssertEqual(Z3_solver_check(ctx, s), Z3_L_TRUE)

        guard let model = Z3_solver_get_model(ctx, s) else {
            XCTFail()
            return
        }
        Z3_model_inc_ref(ctx, model)
        defer { Z3_model_dec_ref(ctx, model) }

        var px : Z3_ast? = nil
        var py : Z3_ast? = nil

         let x = Z3_model_eval(ctx, model, pfa, false, &px)
         let y = Z3_model_eval(ctx, model, negation, false, &py)


//        switch Z3_get_ast_kind(ctx, py) {
//        case Z3_APP_AST:
//            print("app-ast")
//
//        default:
//            print("other-ast")
//        }

        // Z3_solver_assert(ctx, s, contradiction)
        // XCTAssertEqual(Z3_solver_check(ctx, s), Z3_L_FALSE)

        print("========")
















    }
}
