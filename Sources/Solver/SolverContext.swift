import Tptp

protocol SolverContext {
    associatedtype Sort // Tau, Type
    associatedtype Decl //
    associatedtype Term // AST
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

    func negate(formula: Term) -> Term
    func formula(_ lhs: Term, and rhs: Term) -> Term
    func formula(_ lhs: Term, or rhs: Term) -> Term
    func formula(_ lhs: Term, iff rhs: Term) -> Term

    func assert(formula: Term)
}

extension SolverContext {
//    func conjunction<S: Sequence>(_ s: S) -> Self.Term where S.Element == Self.Term {
//        let terms = s.map {
//            $0
//        }
//        return conjunction(terms: terms)
//    }
}

protocol SolverModel {
    associatedtype T : SolverContext
    init?(context: T)
    func satisfies(formula: T.Term) -> Bool?
}