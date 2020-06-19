//
// Created by Alexander Maringele on 19.06.20.
//

import Foundation

/// 't * σ' returns the application of substitution σ on term t.
/// - *caution*: this implementation is more general as
/// the usual definition of substitution, where only variables
/// are substituted with terms. Here any arbitrary subterm can be
/// replaced with an other term, which can lead to ambiguity.
/// - where keys are only variables it matches the definition of substitution
/// - implicit sharing of nodes MAY happen!
public func *<N: Node, S: Substitution>(t: N, σ: S) -> N
        where N == S.K, N == S.V, S.Iterator == DictionaryIterator<N, N> {

    if let tσ = σ[t] {
        return tσ // implicit sharing for reference types
    }

    guard let nodes = t.nodes, nodes.count > 0 else {
        return t // implicit sharing for reference types
    }

    return N.create(t.type, t.symbol, nodes: nodes.map { $0 * σ })
}
