import XCTest
@testable import Tptp
import Runtime

class TptpSequenceTests : AbstractTestCase {
    func testFibonacci() {
        let fibonacci = Tptp.Sequence(
                first: (1, 1),
                step: { (s, t) in
                    guard s <= 100 else {
                        return nil
                    }
                    return (t, s + t)
                },
                data: { (s, _) in s })

        let list = fibonacci.map {
            $0
        }
        XCTAssertEqual([1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144], list)
    }

    func testEvenFibonacci() {
        let fibonacci = Tptp.Sequence(
                first: (1, 1),
                step: { (s, t) in
                    guard s <= 200 else {
                        return nil
                    }
                    return (t, s + t)
                },
                where: { (s, _) in
                    return s % 2 == 0
                },
                data: { (s, _) in s })

        let list = fibonacci.map {
            $0
        }
        XCTAssertEqual([2, 8, 34, 144], list)
    }
}

extension TptpSequenceTests {

    private static var primes10 = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

    private class Simples: Sequence {
        private var sorted = primes10
        private lazy var primes = Set(sorted)

        private func prime(s: Int) -> Bool {
            if primes.contains(s) { return true }

            for p in sorted {
                if s % p == 0 {
                    return false
                }
            }
            sorted.append(s)
            primes.insert(s)
            return true
        }
        func makeIterator() -> Tptp.Iterator<Int,Int> {
            return Tptp.Iterator(
                    first: 2,
                    step: { s in s + 1  },
                    where: { s in self.prime(s: s)  },
                    data: { s in s })
        }

        func first(_ k: Int) -> [Int] {
            for _ in self {
                guard sorted.count < k else { break }
            }
            return Array(sorted[0..<k])
        }

        subscript(idx: Int) -> Int {
            for _ in self {
                guard sorted.count <= idx else { break }
            }
            return sorted[idx]
        }
    }

    class Primes: Sequence {
        private var sorted = primes10

        private func prime(s: Int) -> Bool {

            for p in sorted[1...] {
                if s % p == 0 {
                    return false
                }
            }
            sorted.append(s)
            return true
        }

        subscript(idx: Int) -> Int {
            while idx >= sorted.count {
                var s = sorted.last! + 2
                while !prime(s: s) { s += 2}
            }
            return sorted[idx]
        }

        func makeIterator() -> Tptp.Iterator<Int, Int> {
            return Tptp.Iterator(
                    first: 0,
                    step: { idx in idx + 1  },
                    data: { idx in self[idx] })
        }

        func first(_ k: Int) -> [Int] {
            for _ in self {
                guard sorted.count < k else { break }
            }
            return Array(sorted[0..<k])
        }
    }

    func testPrimes() {
        let simples = Simples()
        let primes = Primes()

        let (_, t) = Time.measure {

            XCTAssertEqual([2], simples.first(1))
            XCTAssertEqual([2, 3, 5, 7, 11, 13, 17, 19, 23, 29], simples.first(10))

            XCTAssertEqual([2], primes.first(1))
            XCTAssertEqual([2, 3, 5, 7, 11, 13, 17, 19, 23, 29], primes.first(10))
        }

        XCTAssertTrue(t.absolute < 0.001, t.absolute.description)

        for count in [1000, 1110, 2000] {

            let (result_p, time_p) = Time.measure {
                primes.first(count)
            }

            let (result_s, time_s) = Time.measure {
                simples.first(count)
            }

            XCTAssertEqual(result_s, result_p)
            XCTAssertTrue(time_p.absolute < time_s.absolute, "\(count) time_p=\(time_p.absolute) • time_s=\(time_s.absolute)")
        }

        let (s, time_s) = Time.measure {
            simples[2100]
        }

        let (p, time_p) = Time.measure {
            simples[2100]
        }

        XCTAssertEqual(s, p)
        XCTAssertTrue(time_p < time_s, "time_p=\(time_p.absolute) • time_s=\(time_s.absolute)")
    }
}
