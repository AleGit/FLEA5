import Tptp

protocol SolverContext {
    associatedtype Symbol
    associatedtype Sort
    associatedtype Function
    associatedtype Predicate
    associatedtype Term
    associatedtype Formula
    associatedtype Model

    var boolTau : Sort { get }
    var freeTau : Sort { get }

    var bot: Formula { get }
    var top: Formula { get }

    var isSatisfiable: Bool { get }
    var model: Model? { get }

    func declare(constant: Symbol) -> Term
    func declare(proposition: Symbol) -> Formula
    func declare(function: Symbol, arity: Int) -> Function
    func declare(predicate: Symbol, arity: Int) -> Predicate

    func apply(function: Function, args: [Term]) -> Term
    func apply(predicate: Predicate, args: [Term]) -> Formula

    func negate(formula: Formula) -> Formula
    func conjunct(formulae: [Formula]) -> Formula
    func disjunct(formulae: [Formula]) -> Formula
    func formula(_ lhs: Formula, iff rhs: Formula) -> Formula

    func assert(formula: Term)
}

extension SolverContext {
    // conjunction shorthands

    func conjunct(formulae: Formula...) -> Formula {
        conjunct(formulae: formulae)
    }

    func conjunct<S: Sequence>(_ sequence: S) -> Formula where S.Element == Formula {
        conjunct(formulae: sequence.map { $0 })
    }

    func formula(_ lhs: Formula, and rhs: Formula) -> Formula {
        conjunct(formulae: lhs, rhs)
    }
}

extension SolverContext {
    // disjunction shorthands

    func disjunct(formulae: Formula...) -> Formula {
        disjunct(formulae: formulae)
    }

    func disjunct<S: Sequence>(_ sequence: S) -> Formula where S.Element == Formula {
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