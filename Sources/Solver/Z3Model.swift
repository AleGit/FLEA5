import CZ3Api

extension Z3{
    final class Model: SolverModel {
        private var context: Z3.Context
        private var model: Z3_model

        init?(context: Z3.Context) {
            guard Z3_solver_check(context.context, context.solver) == Z3_L_TRUE,
                  let model = Z3_solver_get_model(context.context, context.solver) else {
                return nil
            }
            Z3_model_inc_ref(context.context, model)

            self.context = context
            self.model = model
        }
        deinit {
            Z3_model_dec_ref(context.context, self.model)
        }

        func satisfies(formula: Z3.Context.Term) -> Bool? {
            var result: Z3_ast? = nil
            guard Z3_model_eval(context.context, model, formula, false, &result) else {
                return nil
            }
            return result == context.top
        }
    }
}
