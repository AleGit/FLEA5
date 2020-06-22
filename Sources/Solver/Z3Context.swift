import CZ3Api

public struct Z3 {
    final class Context: SolverContext {
        private let context: Z3_context

        public typealias Tau = Z3_sort

        init() {
            let cfg = Z3_mk_config()
            defer {
                Z3_del_config(cfg)
            }

            context = Z3_mk_context(cfg)
        }

        deinit {
            Z3_del_context(context)
        }

        public lazy var boolTau: Tau = Z3_mk_bool_sort(context)
        public lazy var freeTau: Tau = {
            let symbol = Z3_mk_string_symbol(context, "𝛕")
            return Z3_mk_uninterpreted_sort(context, symbol)
        }()
    }
}
