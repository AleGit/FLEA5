public protocol Solver : CustomStringConvertible {
    var name: String { get }
    var version: String { get }
}

extension Solver {
    public var description: String {
        return [name, version].joined(separator: " • ")
    }
}