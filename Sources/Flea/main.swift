import Runtime

Syslog.openLog(options: .console, .pid, .perror)
defer { Syslog.closeLog() }

Syslog.notice { "{ \(Syslog.defaultLogLevel), \(Syslog.logLevel()) } ⊆ [ \(Syslog.minimalLogLevel), \(Syslog.maximalLogLevel) ]" }
Syslog.multiple { "Hello, world!" } 

Syslog.closeLog()

