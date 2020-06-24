import CZ3Api

public struct Z3 {
    public final class Context: SolverContext {

        let context: Z3_context
        let solver: Z3_solver

        typealias Sort = Z3_sort
        typealias Decl = Z3_func_decl
        typealias Term = Z3_ast

        public init() {
            let cfg = Z3_mk_config()
            defer {
                Z3_del_config(cfg)
            }
            context = Z3_mk_context(cfg)
            solver = Z3_mk_solver(context)
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
    func declare(constant: String) -> Z3_ast {
        let symbol = Z3_mk_string_symbol(context, constant)
        return Z3_mk_const(context, symbol, freeTau)
    }

    func declare(proposition: String) -> Z3_ast {
        let symbol = Z3_mk_string_symbol(context, proposition)
        return Z3_mk_const(context, symbol, boolTau)
    }

    func declare(function: String, arity: Int) -> Z3_func_decl {
        let symbol = Z3_mk_string_symbol(context, function)
        let domain = [Z3_sort?](repeatElement(freeTau, count: arity))
        return Z3_mk_func_decl(context, symbol, UInt32(arity), domain, freeTau)
    }

    func declare(predicate: String, arity: Int) -> Z3_func_decl {
        let symbol = Z3_mk_string_symbol(self.context, predicate)
        let domain = [Z3_sort?](repeatElement(freeTau, count: arity))
        return Z3_mk_func_decl(context, symbol, UInt32(arity), domain, boolTau)

    }

    func apply(term: Z3_func_decl, args: [Z3_ast]) -> Z3_ast {
        let args :[Z3_ast?] = args
        return Z3_mk_app(context, term, UInt32(args.count), args)
    }

    func negate(formula: Z3_ast) -> Z3_ast {
        Z3_mk_not(context, formula)
    }

    func and(formulas: Z3_ast...) -> Z3_ast {
        and(formulas: formulas)
    }

    func and(lhs: Z3_ast, rhs: Z3_ast) -> Z3_ast {
        and(formulas: [lhs, rhs])
    }

    func and(formulas: [Z3_ast]) -> Z3_ast {
        let args: [Z3_ast?] = formulas
        return Z3_mk_and(context, UInt32(args.count), args)
    }

    func or(lhs: Z3_ast, rhs: Z3_ast) -> Z3_ast {
        Z3_mk_or(context, 2, [lhs, rhs])
    }

    func iff(lhs: Z3_ast, rhs: Z3_ast) -> Z3_ast {
        Z3_mk_iff(context, lhs, rhs)
    }

    func assert(formula: Term) {
        Z3_solver_assert(context, solver, formula)
    }

}

extension Z3.Context {

    var isSatisfiable: Bool {
        Z3_solver_check(context, solver) == Z3_L_TRUE
    }

    var model: Model? {
        Model(context: self)

    }
}
