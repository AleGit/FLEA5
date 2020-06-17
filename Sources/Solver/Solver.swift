import Foundation

public protocol Solver: CustomStringConvertible, CustomDebugStringConvertible {

    var name: String { get }
    var vers: String { get }
    var arch: String { get }
    var mode: String { get }
    var date: String { get }
}

extension Solver {
    public var description: String {
        return [name, vers].joined(separator: " • ")
    }

    public var debugDescription: String {
        return [name, vers, arch, mode, date].joined(separator: " • ")
    }
}