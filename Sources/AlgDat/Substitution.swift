/// A substitution is a mapping from keys to values, e.g. a dictionary.
public protocol Substitution: ExpressibleByDictionaryLiteral, Sequence, CustomStringConvertible {
    associatedtype K: Hashable
    associatedtype V
    associatedtype Ks : Collection where Ks.Element == K
    associatedtype Vs : Collection where Vs.Element == V

    subscript(_: K) -> V? { get set }

    init(dictionary: [K: V])

    var keys: Ks { get }
    var values: Vs { get }
}

/// A dictionary is a substitution.
extension Dictionary: Substitution {
    public init(dictionary: [Key: Value]) {
        self = dictionary
    }
}

/// A substitution has a pretty description.
extension Substitution // K == V not necessary
        where Iterator == DictionaryIterator<K, V> {
    public var prettyDescription: String {
        let pairs = map { "\($0)↦\($1)" }.joined(separator: ",")
        return "{\(pairs)}"
    }

    public var description: String { return self.prettyDescription }
}

/// 't * σ' returns the application of substitution σ on term t.
/// - *caution*: this implementation is more general as
///   the usual definition of substitution, where only variables
///   are substituted with terms. Here any arbitrary term can be
///   substituted with any other term, which can lead to ambiguity.
/// - where keys are only variables it matches the definition of substitution
/// - implicit sharing of nodes MAY happen!
public func *<N: Term, S: Substitution>(t: N, σ: S) -> N
        where N == S.K, N == S.V, S.Iterator == DictionaryIterator<N, N> {

    if let tσ = σ[t] {
        return tσ // implicit sharing for reference types
    }

    guard let nodes = t.nodes, nodes.count > 0 else {
        // a leaf of the term, e.g. constant or variable
        return t // implicit sharing for reference types
    }

    return N.create(t.type, t.symbol, nodes: nodes.map { $0 * σ })
    // explicit sharing for sharing types
}

/// The composition of two term substitutions.
func *<N: Term, S: Substitution>(lhs: S, rhs: S) -> S?
        where N == S.K, N == S.V, S.Iterator == DictionaryIterator<N, N> {

    var subs = S()
    for (key, value) in lhs {
        subs[key] = value * rhs
    }
    for (key, value) in rhs {
        if let term = subs[key] {
            // allready set
            guard term == value else {
                // and different
                return nil
            }
            // but equal
        } else {
            // not set yet
            subs[key] = value
        }
    }
    return subs
}


/// 't * s' returns the substitution of all variables in t with term s.
/// - Term `s` will be shared when N is a reference type
/// - All nodes above multiple occurences of term `s` are fresh,
///     e.g. unshared when N: Sharing does not apply.
func *<N: Term>(t: N, s: N) -> N {
    guard let nodes = t.nodes else {
        return s // implicit sharing for reference types
    } // any variable is replaced by term s

    return N.create(t.type, t.symbol, nodes: nodes.map { $0 * s })
}

/// `t⊥` substitutes all variables in term `t` with constant `⊥`.
postfix operator ⊥

/// 't⊥' returns the substitution of all variables in t with constant term '⊥'.
/// - Constant term '⊥' will be shared when N is a reference type.
/// - All nodes above multiple occurences of constant term '⊥' are fresh,
///     eg. unshared when N: Sharing does not apply.
postfix func ⊥<N: Term>(t: N) -> N where N.Symbol == String {
    return t * N.constant("⊥")
}

/// properties of term substitutions
extension Substitution where K: Term, V: Term {
    /// Do the runtime types of keys and values match?
    private var isHomogenous: Bool {
        return type(of: keys.first) == type(of: values.first)
    }

    /// Are *variables* mapped to terms?
    private var allKeysAreVariables: Bool {
        return Array(keys).reduce(true) {
            $0 && $1.nodes == nil
        }
    }

    /// Are terms mapped to *variables*?
    private var allValuesAreVariables: Bool {
        return Array(values).reduce(true) {
            $0 && $1.nodes == nil
        }
    }

    /// Are distinct terms mapped to *distinguishable* terms?
    private var isInjective: Bool {
        return keys.count == Set(values).count
    }

    /// A substitution maps variables to terms.
    var isSubstitution: Bool {
        return allKeysAreVariables
    }

    /// A variable substitution maps variables to variables.
    var isVariableSubstitution: Bool {
        return allKeysAreVariables && allValuesAreVariables
    }

    /// A (variable) renaming maps distinct variables to distinguishable variables.
    var isRenaming: Bool {
        return allKeysAreVariables && allValuesAreVariables && isInjective
    }
}