import Tptp

protocol SolverContext {
    associatedtype Sort // Tau, Type
    associatedtype Decl //
    associatedtype Term // AST

    var boolTau : Sort { get }
    var freeTau : Sort { get }

    var bot: Term { get }

    func assert(formula: Term)
}

protocol SolverModel {
    associatedtype T : SolverContext
    init?(context: T)
    func satisfies(formula: T.Term) -> Bool
}