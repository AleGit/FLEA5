import Tptp

public protocol ContextProtocol: CustomStringConvertible {
    associatedtype Tau

    var solverName: String { get }
    var solverVersion: String { get }

    var boolTau : Tau { get }
    var freeTau : Tau { get }



}

extension ContextProtocol {
    public var description: String {
        return [solverName, solverVersion].joined(separator: " • ")
    }
}