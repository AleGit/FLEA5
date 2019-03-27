//  Copyright © 2017 Alexander Maringele. All rights reserved.

#if os(OSX)
    import Darwin
#elseif os(Linux)
    import Glibc
#endif

import Foundation

/// Static wrapper for [syslog](https://en.wikipedia.org/wiki/Syslog),
/// see [man 3 syslog]http://www.unix.com/man-page/POSIX/3posix/syslog/
public struct Syslog {
    static var carping = false
    static var failOnError = true // make this configurable
    
    public enum Priority: Comparable {
        case emergency // LOG_EMERG      system is unusable
        case alert // LOG_ALERT      action must be taken immediately
        case critical // LOG_CRIT       critical conditions
        case error // LOG_ERR        error conditions
        case warning // LOG_WARNING    warning conditions
        case notice // LOG_NOTICE     normal, but significant, condition
        case info // LOG_INFO       informational message
        case debug // LOG_DEBUG      debug-level message

        fileprivate var priority: Int32 {
            switch self {
            case .emergency: return LOG_EMERG
            case .alert: return LOG_ALERT
            case .critical: return LOG_CRIT
            case .error: return LOG_ERR
            case .warning: return LOG_WARNING
            case .notice: return LOG_NOTICE
            case .info: return LOG_INFO
            case .debug: return LOG_DEBUG
            }
        }

        /// Since `Syslog.Priority` is allready `Equatable`
        /// it is sufficient to implement < to adopt `Comparable`
        public static func <(_ lhs: Priority, rhs: Priority) -> Bool {
            return lhs.priority < rhs.priority
        }

        fileprivate init?(string: String) {
            switch string {
            case "emergency": self = .emergency
            case "alert": self = .alert
            case "critical": self = .critical
            case "error": self = .error
            case "warning": self = .warning
            case "notice": self = .notice
            case "info": self = .info
            case "debug": self = .debug
            default: return nil
            }
        }

        static var all = [
            Priority.emergency, Priority.alert, Priority.critical, Priority.error,
            Priority.warning, Priority.notice, Priority.info, Priority.debug,
        ]
    }

    public enum Option {
        case console
        case immediately
        case nowait
        case delayed
        case perror
        case pid
        // LOG_CONS       Write directly to system console if there is an error
        //                while sending to system logger.
        //
        // LOG_NDELAY     Open the connection immediately (normally, the
        //                connection is opened when the first message is
        //                logged).
        //
        // LOG_NOWAIT     Don't wait for child processes that may have been
        //                created while logging the message.  (The GNU C library
        //                does not create a child process, so this option has no
        //                effect on Linux.)
        //
        // LOG_ODELAY     The converse of LOG_NDELAY; opening of the connection
        //                is delayed until syslog() is called.  (This is the
        //                default, and need not be specified.)
        //
        // LOG_PERROR     (Not in POSIX.1-2001 or POSIX.1-2008.)  Print to
        //                stderr as well.
        //
        // LOG_PID        Include PID with each message.
        fileprivate var option: Int32 {
            switch self {
            case .console: return LOG_CONS
            case .immediately: return LOG_NDELAY
            case .nowait: return LOG_NOWAIT
            case .delayed: return LOG_ODELAY
            case .perror: return LOG_PERROR
            case .pid: return LOG_PID
            }
        }
    }

    ///
    fileprivate static var activePriorities = Syslog.maskedPriorities

    /// Syslog is active _after_ reading the configuration.
    fileprivate static var active = false

    /// read in the logging configuration (from file)
    /// TODO: provide a cleaner/better implementation
    static let configuration: [String: Priority]? = {
        /// after the configuration is read the logging is active
        defer { Syslog.active = true }

        // reminder: the logging is not active
        Syslog.prinfo { "reading CONFIGURATION started" }
        defer { Syslog.prinfo { "reading CONFIGURATION finished" } }

        // read configuration file line by line, but
        // ignore comments (#...) and empty lines (whitespace only)
        guard let entries = URL.loggingConfigurationURL?.path.lines(predicate: {
            !($0.hasPrefix("#") || $0.isEmpty)
        }), entries.count > 0 else {
            Syslog.prinfo { "CONFIGURATION file has NO entries (comments and whitespace only)" }
            return nil
        }

        // create configuration
        var cnfg = [String: Priority]()

        for entry in entries {
            let components = entry.components(separatedBy: "::")

            guard components.count == 2,
                let key = components.first?.trimmingWhitespace.pealing,
                let last = components.last else {
                Syslog.prinfo { "invalid CONFIGURATION entry ! \(entry) \(components)" }
                continue
            }

            let lastIndex = last.firstIndex(of: ("#")) ?? last.endIndex
            let value = String(last.prefix(upTo: lastIndex)).trimmingWhitespace.pealing
            guard let p = Priority(string: value) else {
                continue
            }
            cnfg[key] = p

            Syslog.prinfo { "\(entry), \(key), \(p)" }
        }

        #if DEBUG
            print(cnfg)
        #endif

        return cnfg
    }()

    public static var maximalLogLevel: Priority { return Syslog.configuration?["+++"] ?? Priority.error }
    public static var minimalLogLevel: Priority { return Syslog.configuration?["---"] ?? Priority.error }
    public static var defaultLogLevel: Priority { return Syslog.configuration?["***"] ?? Priority.error }

    fileprivate static func loggable(
        _ priority: Priority, _ file: String, _ function: String, _: Int) -> Bool {

        guard Syslog.active,
            Syslog.activePriorities.contains(priority) else {
            return false
        }

        // the configuration is active, i.e. it was read in completely
        // and `priority`` is smaller than the maximal logging priority.

        // the message is always logged when one the two sufficient conditions hold:
        // - there is no configuration at all or
        // - the message priority is not bigger than the minimal logging priority

        guard let configuration = Syslog.configuration // is a configuration available
            , priority > Syslog.minimalLogLevel // is the priority > minimal logging priority
        else { return true }

        // at this point a configuration is available
        // and the minimal logging priority < message »priority«.

        // extract »file« key

        let fileName = URL(fileURLWithPath: file).lastPathComponent
        if fileName.isEmpty {
            Syslog.debug { "Last path element of \(file) could not be extracted." }
        }

        // check for "»file«/»function«" priority
        if let ps = configuration["\(fileName)/\(function)"] {
            return priority <= ps
        }

        // "»file«/»function«" priority does not exist
        // check for "»file«" priority
        if let ps = configuration["\(fileName)"] {
            return priority <= ps
        }

        // "»file«" priority does not exist
        // check for default priority

        return priority <= Syslog.defaultLogLevel
    }
}

extension Syslog {
    fileprivate static var maskedPriorities: Set<Priority> {
        let mask = setlogmask(255)

        _ = setlogmask(mask)
        let array = Priority.all.filter {
            ((1 << $0.priority) | mask) > 0
        }
        return Set(array)
    }

    static var configured: [Priority] {
        return Syslog.activePriorities.sorted { $0.priority < $1.priority }
    }
}

extension Syslog {

    /* void closelog(void); */

    public static func closeLog() {
        closelog()
    }

    /* void openlog(const char *ident, int logopt, int facility); */

    public static func openLog(ident: String? = nil, options: Syslog.Option..., facility: Int32 = LOG_USER) {
        let option = options.reduce(0) { $0 | $1.option }
        openlog(ident, option, facility)
        // ident == nil => use process name
        // idetn != nil => does not work on Linux
    }

    /* int setlogmask(int maskpri); */

    fileprivate static func setLogMask() -> Int32 {
        let mask = Syslog.activePriorities.reduce(Int32(0)) { $0 + (1 << $1.priority) }
        return setlogmask(mask)
    }

    public static func setLogMask(upTo: Syslog.Priority) -> Int32 {
        Syslog.activePriorities = Set(
            Syslog.Priority.all.filter { $0.priority <= upTo.priority }
        )
        return setLogMask()
    }

    public static func setLogMask(priorities: Syslog.Priority...) -> Int32 {
        Syslog.activePriorities = Set(priorities)
        return setLogMask()
    }

    public static func clearLogMask() -> Int32 {
        Syslog.activePriorities = Set<Priority>()
        return setLogMask()
    }

    /*  void syslog(int priority, const char *format, ...); */
    /*  void vsyslog(int priority, const char *format, va_list ap); */
    fileprivate static func vSysLog(
        priority: Priority, args: CVarArg...,
        message: () -> String
    ) {
        withVaList(args) {
            vsyslog(priority.priority, message(), $0)
        }
    }

    fileprivate static func log(
        _ priority: Priority, errcode: Int32 = 0,
        file: String = #file, function: String = #function, line: Int = #line, column: Int = #column,
        message: () -> String
    ) {
        switch errcode {
        case 0:
            // format string contains "%d %d" for line, column
            Syslog.vSysLog(priority: priority,
                           args: line, column) {
                #if os(OSX)
                    return "\(URL(fileURLWithPath: file).lastPathComponent)[%d:%d].\(function) { \(message()) }"
                #elseif os(Linux)
                    return "\(Syslog.loggingTime()) <\(priority)>: \(URL(fileURLWithPath: file).lastPathComponent)[%d:%d].\(function) { \(message()) }"
                #else
                    assert(false, "unknown os")
                    return "unknown os"
                #endif
            }
        default:
            // format string contains "%d %d %m" for line, column, and error code message
            Syslog.vSysLog(priority: priority,
                           args: line, column) {
                #if os(OSX)
                    return "\(URL(fileURLWithPath: file).lastPathComponent)[%d:%d].\(function) '%m' { \(message()) }"
                #elseif os(Linux)
                    return "\(Syslog.loggingTime()) <\(priority)>: \(URL(fileURLWithPath: file).lastPathComponent)[%d:%d].\(function) '%m' { \(message()) }"
                #else
                    assert(false, "unknown os")
                    return "unknown os"
                #endif
            }
        }
    }

    public static func multiple(errcode: Int32 = 0, condition: () -> Bool = { true },
                         file: String = #file, function: String = #function, line: Int = #line, column: Int = #column,
                         message: () -> String
    ) {
        for p in Syslog.Priority.all {
            guard Syslog.loggable(p, file, function, line), condition() else { continue }
            Syslog.log(p, errcode: errcode, file: file, function: function, line: line, column: column) {
                "\(message())"
            }
        }
    }

    public static func fail(condition: @autoclosure () -> Bool = true,
                     file: String = #file, function: String = #function, line: Int = #line, column: Int = #column,
                     message: () -> String
    ) {
        guard condition() else { return }

        log(.error,
            file: file, function: function, line: line, column: column, message: message)

        assert(false, "\(file)/\(function).\(line):\(column) \(message())")
    }

    public static func error(errcode: Int32 = 0, condition: @autoclosure () -> Bool = true,
                      file: String = #file, function: String = #function, line: Int = #line, column: Int = #column,
                      message: () -> String
    ) {
        guard Syslog.loggable(.error, file, function, line), condition() else { return }
        log(.error, errcode: errcode,
            file: file, function: function, line: line, column: column, message: message)

        assert(!failOnError, "\(file)/\(function).\(line):\(column) \(message())")
    }

    public static func warning(errcode: Int32 = 0, condition: @autoclosure () -> Bool = true,
                        file: String = #file, function: String = #function, line: Int = #line, column: Int = #column,
                        message: () -> String
    ) {
        guard Syslog.loggable(.warning, file, function, line), condition() else { return }
        log(.warning, errcode: errcode,
            file: file, function: function, line: line, column: column, message: message)
    }

    public static func notice(errcode: Int32 = 0, condition: @autoclosure () -> Bool = true,
                       file: String = #file, function: String = #function, line: Int = #line, column: Int = #column,
                       message: () -> String
    ) {
        guard Syslog.loggable(.notice, file, function, line), condition() else { return }
        log(.notice, errcode: errcode,
            file: file, function: function, line: line, column: column, message: message)
    }

    public static func info(errcode: Int32 = 0, condition: @autoclosure () -> Bool = true,
                     file: String = #file, function: String = #function, line: Int = #line, column: Int = #column,
                     message: () -> String
    ) {
        guard Syslog.loggable(.info, file, function, line), condition() else { return }
        log(.info, errcode: errcode,
            file: file, function: function, line: line, column: column, message: message)
    }

    static func prinfo(errcode: Int32 = 0, condition: @autoclosure () -> Bool = true,
                       file: String = #file, function: String = #function, line: Int = #line, column: Int = #column,
                       message: () -> String
    ) {
        guard Syslog.loggable(.info, file, function, line), condition() else {

            if CommandLine.options["--prinfo"]?.first == "active" || CommandLine.name.hasSuffix("test"), condition() {
                print("\(Syslog.loggingTime()) <Print,Info>: \(URL(fileURLWithPath: file).lastPathComponent)[\(line):\(column)].\(function) { \(message()) }")
            }
            return
        }
        log(.info, errcode: errcode,
            file: file, function: function, line: line, column: column, message: message)
    }

    public static func debug(errcode: Int32 = 0, condition: @autoclosure () -> Bool = true,
                      file: String = #file, function: String = #function, line: Int = #line, column: Int = #column,
                      message: () -> String
    ) {
        guard Syslog.loggable(.debug, file, function, line), condition() else { return }
        log(.debug, errcode: errcode,
            file: file, function: function, line: line, column: column, message: message)
    }
}

extension Syslog {
    fileprivate static func loggingTime() -> String {
        var t = time(nil) // : time_t
        let tm = localtime(&t) // : struct tm *
        var s = [CChar](repeating: 0, count: 64) // : char s[64];
        strftime(&s, s.count, "%F %T %z", tm)
        return String(cString: s)
    }
}
