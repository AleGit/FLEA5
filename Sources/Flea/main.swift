import Runtime
import Tptp

print("FLEA - First order Logic with Equality Attester (FLEA)")
print("======================================================")

Syslog.openLog(options: .console, .pid, .perror, verbosely: false)
defer { Syslog.closeLog() }

Syslog.notice { "{ \(Syslog.defaultLogLevel), \(Syslog.logLevel()) } ⊆ [ \(Syslog.minimalLogLevel), \(Syslog.maximalLogLevel) ]" }
Syslog.multiple { "💤" }

