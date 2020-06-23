import CZ3Api

public struct Z3 {
    final class Context: SolverContext {
        let context: Z3_context
        let solver: Z3_solver

        typealias Sort = Z3_sort
        typealias Decl = Z3_func_decl
        typealias Term = Z3_ast

        init() {
            let cfg = Z3_mk_config()
            defer {
                Z3_del_config(cfg)
            }
            context = Z3_mk_context(cfg)
            solver = Z3_mk_solver(cfg)
            Z3_solver_inc_ref(context, solver)
        }

        deinit {
            Z3_solver_dec_ref(context, solver)
            Z3_del_context(context)
        }

        lazy var boolTau: Sort = Z3_mk_bool_sort(context)
        lazy var freeTau: Sort = {
            let symbol = Z3_mk_string_symbol(context, "𝛕")
            return Z3_mk_uninterpreted_sort(context, symbol)
        }()

        lazy var top: Term = Z3_mk_true(context)
        lazy var bot: Term = Z3_mk_false(context)

    }
}

extension Z3.Context {

    func assert(formula: Term) {
        Z3_solver_assert(context, solver, formula)
    }

}
