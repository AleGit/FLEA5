import Runtime

print("FLEA - First order Logic with Equality Attester")

func bar() {
    Syslog.multiple { "👁‍🗨" }
}

Syslog.openLog(options: .console, .pid, .perror)
defer { Syslog.closeLog() }

Syslog.notice { "{ \(Syslog.defaultLogLevel), \(Syslog.logLevel()) } ⊆ [ \(Syslog.minimalLogLevel), \(Syslog.maximalLogLevel) ]" }
Syslog.multiple { "💤" } 

bar()

Syslog.closeLog()

