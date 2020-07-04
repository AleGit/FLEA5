import Foundation

extension String {
    static let defaultPeels: [(Character, Character)] = [
        ("\"", "\""), ("'", "'"), ("|", "|"),
        ("(", ")"), ("{", "}"), ("[", "]"), ("<", ">")
    ]


    var trimmingWhitespace: String {
        self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// Returns a string where matching first and last character are removed,
    /// e.g. "debug" -> debug, |x| -> x
    func peeled(peels: [(Character, Character)] = String.defaultPeels) -> String {
        guard let lhs = self.first,
              let rhs = self.last,
              peels.contains(where: { $0 == (lhs, rhs) }) else {
            return self
        }

        let start = self.index(after: self.startIndex)
        let end = self.index(before: self.endIndex)
        let slice = self[start..<end]
        return String(slice).peeled(peels: peels)
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
