import CYices
import Base

public struct Yices {
    public final class Context: SolverContext {
        private static var lock: Lock = Base.Mutex()
        private static var contextCount = 0
        let context: OpaquePointer

        typealias Sort = type_t
        typealias Func = type_t
        typealias Term = term_t

        public init() {
            Context.lock.lock()
            defer {
                Context.lock.unlock()
            }
            if Context.contextCount == 0 {
                yices_init()
            }

            Context.contextCount += 1
            context = yices_new_context(nil)
        }

        deinit {
            Context.lock.lock()
            defer {
                Context.lock.unlock()
            }

            yices_free_context(context)
            Context.contextCount -= 1

            if Context.contextCount == 0 {
                yices_exit()
            }
        }

        lazy var boolTau: Sort = yices_bool_type()
        lazy var freeTau: Sort = {
            let name = "𝛕"
            var tau = yices_get_type_by_name(name)
            if tau == NULL_TYPE {
                tau = yices_new_uninterpreted_type()
                yices_set_term_name(tau, name)
            }
            return tau
        }()

        lazy var top: Term = yices_true()
        lazy var bot: Term = yices_false()
    }
}

extension Yices.Context {

    private func declare(symbol: String, tau: Sort) -> term_t {
        var term = yices_get_term_by_name(symbol)
        if term == NULL_TERM {
            term = yices_new_uninterpreted_term(tau)
            yices_set_term_name(term, symbol)
        }
        else {
            Swift.assert(tau == yices_type_of_term(term))
        }
        return term
    }


    func declare(constant: String) -> term_t {
        declare(symbol: constant, tau: self.freeTau)
    }

    func declare(proposition: String) -> term_t {
        declare(symbol: "\(proposition)_p", tau: self.boolTau)
    }

    func declare(function: String, arity: Int) -> type_t {
        let domain = [Term](repeatElement(self.freeTau, count: arity))
        let tau = yices_function_type(UInt32(arity), domain, self.freeTau)
        return declare(symbol: "\(function)_f\(arity)", tau: tau)
    }

    func declare(predicate: String, arity: Int) -> type_t {
        let domain = [type_t](repeatElement(self.freeTau, count: arity))
        let tau = yices_function_type(UInt32(arity), domain, self.boolTau)
        return declare(symbol: "\(predicate)_p\(arity)", tau: tau)
    }

    private func apply(_ fp: term_t, args: [term_t]) -> term_t {
        yices_application(fp, UInt32(args.count), args)
    }

    func apply(function: term_t, args: [term_t]) -> term_t {
        yices_application(function, UInt32(args.count), args)
    }

    func apply(predicate: term_t, args: [term_t]) -> term_t {
        yices_application(predicate, UInt32(args.count), args)
    }

}

extension Yices.Context {

    func negate(formula: term_t) -> term_t {
        yices_not(formula)
    }

    func conjunct(formulae: [term_t]) -> term_t {
        var args = formulae
        return yices_and(UInt32(args.count), &args)
    }

    func disjunct(formulae: [term_t]) -> term_t {
        var args = formulae
        return yices_or(UInt32(args.count), &args)
    }

    func formula(_ lhs: term_t, iff rhs: term_t) -> term_t {
        yices_iff(lhs, rhs)
    }
}

extension Yices.Context {

    func assert(formula: term_t) {
        yices_assert_formula(context, formula)
    }

    var isSatisfiable: Bool {
        yices_check_context(context, nil) == STATUS_SAT
    }

    var model: Model? {
        Model(context: self)
    }
}
