

extension Node {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        guard lhs.symbol == rhs.symbol, lhs.nodes == rhs.nodes else {
            return false
        }
        return true
    }
}

extension Node {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
        hasher.combine(nodes)
    }
}