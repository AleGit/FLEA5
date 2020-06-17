/// Equatable
extension Node {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        guard lhs.key == rhs.key, lhs.nodes == rhs.nodes else {
            return false
        }
        return true
    }
}

/// Hashable
extension Node {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(nodes)
    }
}