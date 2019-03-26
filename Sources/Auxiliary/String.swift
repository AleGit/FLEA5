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
}