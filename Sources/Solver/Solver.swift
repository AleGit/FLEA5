import Foundation

public protocol Solver : CustomStringConvertible {
    static var shared : Self { get }

    var name : String { get }
    var version : String { get }

}

extension Solver {
    public var description: String {
        return name + " " + version
    }
}