import Foundation
import CZ3Api

public struct Z3 {
    final class Context: SolverContext {
        private let context: OpaquePointer

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

        public typealias Tau = Z3_sort

        public lazy var boolTau: Tau = Z3_mk_bool_sort(context)
        public lazy var freeTau: Tau = {
            let symbol = Z3_mk_string_symbol(self.context, "𝛕")
            return Z3_mk_uninterpreted_sort(context, symbol)
        }()

        var solverName: String {
            return "Z3"
        }

        var solverVersion: String {
            var major = UInt32.zero
            var minor = UInt32.zero
            var build = UInt32.zero
            var revision = UInt32.zero
            Z3_get_version(&major, &minor, &build, &revision)
            return [major, minor, build, revision].map {
                "\($0)"
            }.joined(separator: ".")
        }

    }
}
