import Foundation
import CZ3Api

final class Z3SATSolver : Z3Solver {
    private let context : OpaquePointer
    init() {
        let cfg = Z3_mk_config()
        defer { Z3_del_config(cfg) }

        context = Z3_mk_context(cfg)
    }

    deinit {
        Z3_del_context(context)
    }

}
