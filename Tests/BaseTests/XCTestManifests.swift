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

extension CollectionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CollectionTests = [
        ("testDecomposingArray", testDecomposingArray),
        ("testDecomposingDictionary", testDecomposingDictionary),
        ("testDecomposingSet", testDecomposingSet),
        ("testDecomposingString", testDecomposingString),
        ("testTest", testTest),
    ]
}

extension CommandLineTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CommandLineTests = [
        ("testName", testName),
        ("testOptions", testOptions),
        ("testParameters", testParameters),
        ("testTest", testTest),
    ]
}

extension ComparableTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ComparableTests = [
        ("testEmbank", testEmbank),
        ("testTest", testTest),
    ]
}

extension FilePathTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FilePathTests = [
        ("testTest", testTest),
        ("testTptpPath", testTptpPath),
    ]
}

extension SequenceTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SequenceTests = [
        ("testAll", testAll),
        ("testCount", testCount),
        ("testOne", testOne),
        ("testTest", testTest),
    ]
}

extension StringTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__StringTests = [
        ("testContainsAll", testContainsAll),
        ("testContainsOne", testContainsOne),
        ("testIndex", testIndex),
        ("testPealed", testPealed),
        ("testRange", testRange),
        ("testTest", testTest),
        ("testTrimmed", testTrimmed),
        ("testTrimmingWhitespace", testTrimmingWhitespace),
    ]
}

extension SyslogTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SyslogTests = [
        ("testError", testError),
        ("testMultiple", testMultiple),
        ("testTest", testTest),
        ("testWarning", testWarning),
    ]
}

extension TimeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__TimeTests = [
        ("testMeasure", testMeasure),
        ("testTest", testTest),
    ]
}

extension URLTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__URLTests = [
        ("testTest", testTest),
        ("testTptpURL", testTptpURL),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ATestCase.__allTests__ATestCase),
        testCase(CollectionTests.__allTests__CollectionTests),
        testCase(CommandLineTests.__allTests__CommandLineTests),
        testCase(ComparableTests.__allTests__ComparableTests),
        testCase(FilePathTests.__allTests__FilePathTests),
        testCase(SequenceTests.__allTests__SequenceTests),
        testCase(StringTests.__allTests__StringTests),
        testCase(SyslogTests.__allTests__SyslogTests),
        testCase(TimeTests.__allTests__TimeTests),
        testCase(URLTests.__allTests__URLTests),
    ]
}
#endif