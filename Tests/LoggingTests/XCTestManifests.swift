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

extension BasicLoggingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BasicLoggingTests = [
        ("testHelloWorld", testHelloWorld),
        ("testTest", testTest),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ATestCase.__allTests__ATestCase),
        testCase(BasicLoggingTests.__allTests__BasicLoggingTests),
    ]
}
#endif