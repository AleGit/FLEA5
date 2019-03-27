import Auxiliary

Syslog.openLog(options: .console, .pid, .perror)
let logLevel = Syslog.maximalLogLevel
_ = Syslog.setLogMask(upTo: logLevel)

Syslog.multiple { "Hello, world!"}

Syslog.closeLog()

