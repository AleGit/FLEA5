import CZ3Api

public struct Z3 {
    public final class Context: SolverContext {

        let context: Z3_context
        let solver: Z3_solver

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

        lazy var boolTau: Z3_sort = Z3_mk_bool_sort(context)
        lazy var freeTau: Z3_sort = {
            let symbol = Z3_mk_string_symbol(context, "𝛕")
            return Z3_mk_uninterpreted_sort(context, symbol)
        }()

        lazy var top: Z3_ast = Z3_mk_true(context)
        lazy var bot: Z3_ast = Z3_mk_false(context)
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

    private func apply(_ fp: Z3_func_decl, args: [Z3_ast]) -> Z3_ast {
        let args :[Z3_ast?] = args
        return Z3_mk_app(context, fp, UInt32(args.count), args)
    }

    func apply(function: Z3_func_decl, args: [Z3_ast]) -> Z3_ast {
        apply(function, args: args)
    }

    func apply(predicate: Z3_func_decl, args: [Z3_ast]) -> Z3_ast {
        apply(predicate, args: args)
    }
}

extension Z3.Context {

    func negate(formula: Z3_ast) -> Z3_ast {
        Z3_mk_not(context, formula)
    }

    func conjunct(formulae: [Z3_ast]) -> Z3_ast {
        let args: [Z3_ast?] = formulae
        return Z3_mk_and(context, UInt32(args.count), args)
    }

    func disjunct(formulae: [Z3_ast]) -> Z3_ast {
        let args: [Z3_ast?] = formulae
        return Z3_mk_or(context, UInt32(args.count), args)
    }

    func formula(_ lhs: Z3_ast, iff rhs: Z3_ast) -> Z3_ast {
        Z3_mk_iff(context, lhs, rhs)
    }

}

extension Z3.Context {

    func assert(formula: Z3_ast) {
        Z3_solver_assert(context, solver, formula)
    }

    var isSatisfiable: Bool {
        Z3_solver_check(context, solver) == Z3_L_TRUE
    }

    var model: Model? {
        Model(context: self)

    }
}
