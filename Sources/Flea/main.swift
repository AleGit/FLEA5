import Runtime

print("FLEA - First order Logic with Equality Attester")

Syslog.openLog(options: .console, .pid, .perror)
defer { Syslog.closeLog() }

Syslog.notice { "{ \(Syslog.defaultLogLevel), \(Syslog.logLevel()) } ⊆ [ \(Syslog.minimalLogLevel), \(Syslog.maximalLogLevel) ]" }
Syslog.multiple { "Hello, world!" } 

Syslog.closeLog()

