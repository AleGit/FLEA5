import Tptp

public protocol SolverContext {
    associatedtype Tau

    var boolTau : Tau { get }
    var freeTau : Tau { get }
}

public protocol SolverContextInfo : CustomStringConvertible {
    var solverName: String { get }
    var solverVersion: String { get }
}

extension SolverContextInfo {
    public var description: String {
        return [solverName, solverVersion].joined(separator: " • ")
    }
}