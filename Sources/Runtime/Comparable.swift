
func embank<T>(lo: T, hi: T, _ level: T) -> T where T:Comparable {
    return min(max(lo, level), hi)
}