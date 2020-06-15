
func embank<T>(lo: T, hi: T, _ level: T) -> T where T:Comparable {
    min(max(lo, level), hi)
}