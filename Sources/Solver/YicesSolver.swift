import CYices
import Runtime

final class YicesSolver {
    static var shared = YicesSolver()

    private init() {
        yices_init()
    }
    deinit {
        yices_exit()
    }

    let name = "Yices"
}

extension YicesSolver : Solver {

    var version: String {
        return String(validatingUTF8: yices_version) ?? "n/a"
    }

}

