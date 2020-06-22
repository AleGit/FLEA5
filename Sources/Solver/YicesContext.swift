import CYices
import Base

public struct Yices {
    public final class Context: ContextProtocol {

        private static var lock: Lock = Base.Mutex()
        private static var contextCount = 0
        private let context: OpaquePointer

        public typealias Tau = type_t
        public typealias Term = term_t

        lazy public var boolTau: Tau = yices_bool_type()
        lazy public var freeTau: Tau = {
            Yices.Context.lock.lock()
            defer { Yices.Context.lock.lock() }

            let name = "𝛕"
            var tau = yices_get_type_by_name(name)
            if tau == NULL_TYPE {
                tau = yices_new_uninterpreted_type()
                yices_set_term_name(tau, name)
            }
            return tau
        }()

        public init() {
            Context.lock.lock()
            defer { Context.lock.unlock() }
            if Context.contextCount == 0 {
                yices_init()
            }

            Context.contextCount += 1
            context = yices_new_context(nil)


        }

        deinit {
            Context.lock.lock()
            defer { Context.lock.unlock() }

            yices_free_context(context)
            Context.contextCount -= 1

            if Context.contextCount == 0 {
                yices_exit()
            }
        }

        public var solverName: String {
            return "Yices2"
        }

        public var solverVersion: String {
            return String(validatingUTF8: yices_version) ?? "n/a"
        }

        public var arch: String {
            return String(validatingUTF8: yices_build_arch) ?? "n/a"
        }

        public var mode: String {
            return String(validatingUTF8: yices_build_mode) ?? "n/a"
        }

        public var date: String {
            return String(validatingUTF8: yices_build_date) ?? "n/a"
        }
    }
}
