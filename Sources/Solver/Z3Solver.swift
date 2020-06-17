import CZ3Api

protocol Z3Solver : Solver { }

extension Z3Solver {

    var name : String {
        return "Z3"
    }
    
    var vers: String {
        var major = UInt32.zero
        var minor = UInt32.zero
        var build = UInt32.zero
        var revision = UInt32.zero
        Z3_get_version(&major, &minor, &build, &revision)
        return [major, minor, build, revision].map { "\($0)" }.joined(separator: ".")
    }

    var arch: String {
        return "n/a"
    }

    var mode: String {
        return "n/a"
    }

    var date : String {
        return "n/a"
    }
}
