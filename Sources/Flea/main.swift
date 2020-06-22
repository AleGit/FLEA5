import Base
import Tptp
import Solver

var ctx1 = Yices.Context()
var ctx2 = Yices.Context()

print("FLEA - First order Logic with Equality Attester (FLEA)")
print("======================================================")


Syslog.openLog(options: .console, .pid, .perror)
defer { Syslog.closeLog() }

let (_, t) = Time.measure {

    Syslog.notice {
        "{ \(Syslog.defaultLogLevel), \(Syslog.logLevel()) } ⊆ [ \(Syslog.minimalLogLevel), \(Syslog.maximalLogLevel) ]"
    }
    Syslog.multiple {
        "💤"
    }
}



