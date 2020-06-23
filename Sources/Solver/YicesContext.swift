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
            Yices.Context.lock.lock()
            defer {
                Yices.Context.lock.lock()
            }

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
    func assert(formula: Term) {
        yices_assert_formula(context, formula)
    }

}
