import CYices

protocol Y2Solver : Solver { }

extension Y2Solver {

    var name : String {
        return "Yices2"
    }

    var vers: String {
        return String(validatingUTF8: yices_version) ?? "n/a"
    }

    var arch: String {
        return String(validatingUTF8: yices_build_arch) ?? "n/a"
    }

    var mode: String {
        return String(validatingUTF8: yices_build_mode) ?? "n/a"
    }

    var date : String {
        return String(validatingUTF8: yices_build_date) ?? "n/a"
    }

}

