import CYices

final class Y2SATSolver: Y2Solver {
    private let context: OpaquePointer

    init() {
        context = yices_new_context(nil)
        print()
    }

    deinit {
        yices_free_context(context)
    }
}
