import Tptp

protocol SolverContext {
    associatedtype Sort // Tau, Type
    associatedtype Decl //
    associatedtype Term // AST
    associatedtype Formula
    associatedtype Model

    var boolTau : Sort { get }
    var freeTau : Sort { get }

    var bot: Term { get }
    var top: Term { get }

    var isSatisfiable: Bool { get }
    var model: Model? { get }

    func declare(constant: String) -> Term

    func declare(proposition: String) -> Term

    func declare(function: String, arity: Int) -> Decl

    func declare(predicate: String, arity: Int) -> Decl

    func apply(term: Term, args: [Term]) -> Term

    func negate(formula: Formula) -> Formula
    func conjunct(formulae: [Formula]) -> Formula
    func disjunct(formulae: [Formula]) -> Formula
    func formula(_ lhs: Formula, iff rhs: Formula) -> Formula

    func assert(formula: Term)
}

extension SolverContext {
    // conjunction shorthands

    func conjunct(formulae: Self.Formula...) -> Formula {
        conjunct(formulae: formulae)
    }

    func conjunct<S: Sequence>(_ sequence: S) -> Self.Formula where S.Element == Self.Formula {
        conjunct(formulae: sequence.map { $0 })
    }

    func formula(_ lhs: Formula, and rhs: Formula) -> Formula {
        conjunct(formulae: lhs, rhs)
    }
}

extension SolverContext {
    // disjunction shorthands

    func disjunct(formulae: Self.Formula...) -> Formula {
        disjunct(formulae: formulae)
    }

    func disjunct<S: Sequence>(_ sequence: S) -> Self.Formula where S.Element == Self.Formula {
        disjunct(formulae: sequence.map { $0 })
    }

    func formula(_ lhs: Formula, or rhs: Formula) -> Formula {
        disjunct(formulae: lhs, rhs)
    }

}

protocol SolverModel {
    associatedtype T : SolverContext
    init?(context: T)
    func satisfies(formula: T.Term) -> Bool?
}