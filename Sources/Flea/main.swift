import Runtime

Syslog.openLog(options: .pid, .perror)
defer { Syslog.closeLog() }

Syslog.failOnError = false
// let logLevel = Syslog.maximalLogLevel
// _ = Syslog.setLogMask(upTo: logLevel)

let level = Syslog.logLevel()

Syslog.error { "\n { \(Syslog.defaultLogLevel), \(Syslog.logLevel()) } ⊆ [ \(Syslog.minimalLogLevel), \(Syslog.maximalLogLevel) ]" }

Syslog.multiple { "Hello, world!"}

Syslog.closeLog()

