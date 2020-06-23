import CYices

extension Yices {
    final class Model: SolverModel {

        private var context: Yices.Context
        private var model: OpaquePointer

        init?(context: Yices.Context) {
            guard yices_check_context(context.context, nil) == STATUS_SAT,
                  let model = yices_get_model(context.context, 0)
                    else {
                return nil
            }
            self.context = context
            self.model = model
        }

        deinit {
            yices_free_model(model)
        }

        func satisfies(formula: Yices.Context.Term) -> Bool? {
            switch yices_formula_true_in_model(self.model, formula) {
            case 1:
                return true
            case 0:
                return false
            default:
                return nil
            }
        }
    }
}
