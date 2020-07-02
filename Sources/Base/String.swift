import Foundation

extension String {

    var trimmingWhitespace: String {
        self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// Returns a string where the first and the last character were removed,
    /// e.g. "debug" -> debug
    var pealed: String {
        guard self.count > 1 else {
            // ""  -> ""
            // "a" -> ""
            return ""
        }

        guard self.first == self.last else {
            return self
        }
        let start = self.index(after: self.startIndex)
        let end = self.index(before: self.endIndex)
        let slice = self[start..<end]
        return String(slice)
    }

    /// Is at least one element of a sequence of strings
    /// a substring of this string?
    func containsOne<S: Sequence>(_ strings: S) -> Bool
            where S.Element == String {
        strings.reduce(false) {
            $0 || self.contains($1)
        }
    }

    /// Are all elements of a sequence of strings
    /// substrings of this string?
    func containsAll<S: Sequence>(_ strings: S) -> Bool
            where S.Element == String {
        strings.reduce(true) {
            $0 && self.contains($1)
        }
    }
}