import CYices
import Runtime

/**
https://yices.csl.sri.com
*/
struct Yices {
    /// Get yices version string
    static var versionString: String {
        return String(validatingUTF8: yices_version) ?? "n/a"
    }

    static var version: [UInt32] {
        return versionString.components(separatedBy: ".").map {
            UInt32($0) ?? UInt32()
        }
    }
}

extension Yices {
    /// Check if code represents error code, i.e. code < 0
    static func check(code: Int32, label: String) -> Bool {
        if code < 0 {
            Syslog.error { "\(label) \(code) \(errorString)" }
            return false
        }

        return true
    }

    /// Get yices error string
    static var errorString: String {
        let cstring = yices_error_string()
        guard cstring != nil else {
            return "yices_error_string() n/a"
        }

        guard let string = String(validatingUTF8: cstring!) else {
            return "yices_error_string() n/c"
        }

        return string
    }
}


extension Yices {
    static func setUp() {
        yices_init()
    }

    static func tearDown() {
        yices_exit()
    }
}