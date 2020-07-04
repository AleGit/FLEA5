/// - Parameters:
///   - lo: the lower bound for level
///   - hi: the upper bound for level
///   - level: the level to be bound
/// - Returns: 'nil' iff (lo > hi)
/// 'lo' iff (hi ≥ lo > level)
/// 'hi' iff (level > hi ≥ lo)
/// 'level' iff (hi ≥ level ≥ lo)
func embank<T>(lo: T, hi: T, _ level: T) -> T? where T:Comparable {
    guard lo <= hi else {
        return nil
    }
    return min(max(lo, level), hi)
}