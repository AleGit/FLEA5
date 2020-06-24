import CYices
import Base

public struct Yices {
    public final class Context: SolverContext {
        private static var lock: Lock = Base.Mutex()
        private static var contextCount = 0
        let context: OpaquePointer

        typealias Sort = type_t
        typealias Decl = type_t
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
        var c = yices_get_term_by_name(symbol)
        if c == NULL_TERM {
            c = yices_new_uninterpreted_term(tau)
            yices_set_term_name(c, symbol)
        }
        else {
            Swift.assert(tau == yices_type_of_term(c))
        }
        return c
    }


    func declare(constant: String) -> term_t {
        declare(symbol: constant, tau: self.freeTau)
    }

    func declare(proposition: String) -> term_t {
        declare(symbol: proposition, tau: self.boolTau)
    }

    func declare(function: String, arity: Int) -> type_t {
        let domain = [Term](repeatElement(self.freeTau, count: arity))
        let tau = yices_function_type(UInt32(arity), domain, self.freeTau)
        return declare(symbol: function, tau: tau)
    }

    func declare(predicate: String, arity: Int) -> type_t {
        let domain = [type_t](repeatElement(self.freeTau, count: arity))
        let tau = yices_function_type(UInt32(arity), domain, self.boolTau)
        return declare(symbol: predicate, tau: tau)
    }

    func apply(term: term_t, args: [term_t]) -> term_t {
        yices_application(term, UInt32(args.count), args)
    }

    func negate(formula: term_t) -> term_t {
        yices_not(formula)
    }

    func formula(_ lhs: term_t, and rhs: term_t) -> term_t {
        yices_and2(lhs, rhs)
    }

    func and(args: [term_t]) -> term_t {
        return bot

    }

    func formula(_ lhs: term_t, or rhs: term_t) -> term_t {
        yices_or2(lhs, rhs)
    }

    func formula(_ lhs: term_t, iff rhs: term_t) -> term_t {
        yices_iff(lhs, rhs)
    }

    func assert(formula: term_t) {
        yices_assert_formula(context, formula)
    }

}

extension Yices.Context {


    var isSatisfiable: Bool {
        yices_check_context(context, nil) == STATUS_SAT
    }

    var model: Model? {
        Model(context: self)
    }
}
