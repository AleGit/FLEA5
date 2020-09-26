#if !canImport(ObjectiveC)
import XCTest

extension ATestCase {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ATestCase = [
        ("testTest", testTest),
    ]
}

extension MultiSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MultiSetTests = [
        ("testBasics", testBasics),
        ("testCustomStringConvertible", testCustomStringConvertible),
        ("testEquatable", testEquatable),
        ("testExpressibleByArrayLiteral", testExpressibleByArrayLiteral),
        ("testExpressibleByDictionaryLiteral", testExpressibleByDictionaryLiteral),
        ("testInitWithDictionary", testInitWithDictionary),
        ("testInitWithKeyValuePairs", testInitWithKeyValuePairs),
        ("testInitWithRandomSequence", testInitWithRandomSequence),
        ("testInitWithSequence", testInitWithSequence),
        ("testTest", testTest),
    ]
}

extension PositionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PositionTests = [
        ("testEquals", testEquals),
        ("testMinus", testMinus),
        ("testParallel", testParallel),
        ("testPlus", testPlus),
        ("testPrefix", testPrefix),
        ("testPrettyDescription", testPrettyDescription),
        ("testStrictPrefix", testStrictPrefix),
        ("testTest", testTest),
    ]
}

extension SequenceTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SequenceTests = [
        ("testFibonacci", testFibonacci),
        ("testPrime", testPrime),
        ("testPrimes", testPrimes),
        ("testTest", testTest),
    ]
}

extension SubstitutionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SubstitutionTests = [
        ("testApply", testApply),
        ("testCompositions", testCompositions),
        ("testIsHomogenous", testIsHomogenous),
        ("testIsNotHomogenous", testIsNotHomogenous),
        ("testNumbers", testNumbers),
        ("testSimpleComposition", testSimpleComposition),
        ("testTest", testTest),
    ]
}

extension TermTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__TermTests = [
        ("testTest", testTest),
    ]
}

extension TrieTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__TrieTests = [
        ("testTest", testTest),
    ]
}

extension UnificationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__UnificationTests = [
        ("testBasics", testBasics),
        ("testMultiple", testMultiple),
        ("testTest", testTest),
    ]
}

extension WeakSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__WeakSetTests = [
        ("testBar", testBar),
        ("testFoo", testFoo),
        ("testTest", testTest),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ATestCase.__allTests__ATestCase),
        testCase(MultiSetTests.__allTests__MultiSetTests),
        testCase(PositionTests.__allTests__PositionTests),
        testCase(SequenceTests.__allTests__SequenceTests),
        testCase(SubstitutionTests.__allTests__SubstitutionTests),
        testCase(TermTests.__allTests__TermTests),
        testCase(TrieTests.__allTests__TrieTests),
        testCase(UnificationTests.__allTests__UnificationTests),
        testCase(WeakSetTests.__allTests__WeakSetTests),
    ]
}
#endif
