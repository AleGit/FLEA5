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

extension AlgorithmsTest {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__AlgorithmsTest = [
        ("testCombinations", testCombinations),
        ("testPermutations", testPermutations),
        ("testTest", testTest),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ATestCase.__allTests__ATestCase),
        testCase(AlgorithmsTest.__allTests__AlgorithmsTest),
    ]
}
#endif