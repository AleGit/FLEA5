import Foundation
import CZ3Api

final class Z3Solver {
    static var shared = Z3Solver()

    private init() {}
    deinit {}

    let name = "Z3"
}

extension Z3Solver : Solver {
    var version: String {
        var major = UInt32.zero
        var minor = UInt32.zero
        var build = UInt32.zero
        var revision = UInt32.zero
        Z3_get_version(&major, &minor, &build, &revision)
        return [major, minor, build, revision].map { "\($0)" }.joined(separator: ".")
    }
}
