import Foundation

extension String {

    var trimmingWhitespace: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var pealing: String {
        let start = self.index(after: self.startIndex)        
        let end = self.index(before: self.endIndex)
        let slice = self[start..<end]

        return String(slice)
    }
/*

    /// check if the string has an uppercase character at given index.
    func isUppercased(at: Index) -> Bool {

        let range = at ..< index(after: at)
        return rangeOfCharacter(from: .uppercaseLetters, options: [], range: range) != nil
    }

    /// check if at least on member of a sequence is a substring of the string
    func containsOne<S: Sequence>(_ strings: S) -> Bool
        where S.Element == String {
        return strings.reduce(false) { $0 || self.contains($1) }
    }

    /// check if all members of a sequence are substrings of the string
    func containsAll<S: Sequence>(_ strings: S) -> Bool
        where S.Element == String {
        return strings.reduce(true) { $0 && self.contains($1) }
    }
    */
}