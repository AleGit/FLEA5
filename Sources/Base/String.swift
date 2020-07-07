import Foundation

//struct Peel : Hashable {
//    let lhs: Character
//    let rhs: Character
//
//    init(_ lhs: Character, _ rhs: Character) {
//        self.lhs = lhs
//        self.rhs = rhs
//    }
//
//    static let defaultPeels : [Peel] = ["\"", "'", "|", "()", "{}", "[]", "<>"]
//}

typealias Peel = (Character, Character)

fileprivate let defaultPeels : [Peel] = [("\"", "\""), ("'","'"), ("|","|"), ("(",")"), ("{","}"), ("[","]"), ("<",">")]

extension String {
    var trimmingWhitespace: String {
        self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func trimmed(by: (UInt, UInt)) -> String? {
        guard by.0 + by.1 > 0 else { return self }

        guard self.count >= by.0 + by.1 else { return nil }

        let start = self.index(self.startIndex, offsetBy: Int(by.0))
        let end = self.index(self.endIndex, offsetBy: -Int(by.1))
        guard start <= end else { return nil }

        let slice = self[start..<end]
        return String(slice)
    }

    func trimmed(by: UInt) -> String? {
        trimmed(by: (by, by))
    }

    subscript(_ i: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: i)
        return self[index]
    }
    subscript(_ r: Range<Int>) -> Substring {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy: r.upperBound)
        return self[start..<end]
    }

    subscript(_ r: ClosedRange<Int>) -> Substring {
        self[r.lowerBound..<(r.upperBound+1)]
    }

    /// Returns a string where matching first and last character are removed,
    /// e.g. "debug" -> debug, |x| -> x
    func peeled(peels: [Peel] = defaultPeels) -> String {
        guard let lhs = self.first,
              let rhs = self.last,
              peels.contains(where: { $0.0 == lhs && $0.1 == rhs }) else {
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
