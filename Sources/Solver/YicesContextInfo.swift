import CYices

extension Yices.Context: SolverContextInfo {

    public var solverName: String {
        return "Yices2"
    }

    public var solverVersion: String {
        return String(validatingUTF8: yices_version) ?? "n/a"
    }

    public var arch: String {
        return String(validatingUTF8: yices_build_arch) ?? "n/a"
    }

    public var mode: String {
        return String(validatingUTF8: yices_build_mode) ?? "n/a"
    }

    public var date: String {
        return String(validatingUTF8: yices_build_date) ?? "n/a"
    }
}