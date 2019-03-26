import Foundation

typealias FilePath = String

extension FilePath {
    var fileSize: Int? {
        var status = stat()

        let code = stat(self, &status)
        switch (code, S_IFREG & status.st_mode) {
        case (0, S_IFREG):
            return Int(status.st_size)
        default:
            return nil
        }
        // guard code == 0 else { return nil }
        // return Int(status.st_size)
    }

    var isAccessible: Bool {
        guard let f = fopen(self, "r") else {
            Syslog.info { "Path \(self) is not accessible." }
            return false
        }
        fclose(f)
        return true
    }

    var isAccessibleDirectory: Bool {
        guard let d = opendir(self) else {
            Syslog.info { "Directory \(self) does not exist." }
            return false
        }
        closedir(d)
        return self.isAccessible
    }
}

extension FilePath {
    var content: String? {
        #if os(OSX) /**************************************************************/

            return try? String(contentsOfFile: self)

        #elseif os(Linux) /********************************************************/

            Syslog.notice {
                "#Linux #workaround : init(contentsOfFile:usedEncoding:) is not yet implemented."
            }

            guard let f = fopen(self, "r") else {
                return nil
            }
            defer { fclose(f) }

            guard let bufsize = self.fileSize else {
                return nil
            }
            var buf = [CChar](repeating: CChar(0), count: bufsize + 16)
            guard fread(&buf, 1, bufsize, f) == bufsize else { return nil }
            return String(validatingUTF8: buf)

        #endif /******************************************************************/
    }

    func lines(predicate: (String) -> Bool = { _ in true }) -> [String]? {
        guard let f = fopen(self, "r") else {
            Syslog.error { "File at '\(self)' could not be opened." }
            return nil
        }
        guard let bufsize = self.fileSize else {
            return nil
        }

        var strings = [String]()
        var buf = [CChar](repeating: CChar(0), count: bufsize)

        while let s = fgets(&buf, Int32(bufsize), f) {
            guard
                let string = String(validatingUTF8: s)?.trimmingWhitespace,
                predicate(string) else {
                continue
            }

            strings.append(string)
        }
        return strings
    }
}


