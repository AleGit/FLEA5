import XCTest
@testable import Base

final class CommandLineTests: ATestCase {
    typealias CL = CommandLine
    func testName() {
        #if os(macOS)
        XCTAssertEqual(
            "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest", 
            CL.name)
            #else
        XCTAssertTrue( 
            CL.name.hasSuffix("FLEA5PackageTests.xctest"))

            #endif
    }

    /**
    - CLion
        - ["-XCTest", "BaseTests.CommandLineTests/testParameters", "/Users/alm/UIBK/FLEA5/.build/debug/FLEA5PackageTests.xctest"]
        - ["-XCTest", "BaseTests.CommandLineTests", "/Users/alm/UIBK/FLEA5/.build/debug/FLEA5PackageTests.xctest"]
        - ["-XCTest", "BaseTests,BaseTests.StringTests,BaseTests.SyslogTests,BaseTests.ATestCase,BaseTests.SequenceTests,BaseTests.TimeTests,BaseTests.CollectionTests,BaseTests.CommandLineTests", "/Users/alm/UIBK/FLEA5/.build/debug/FLEA5PackageTests.xctest"]


    - swift test
      ["/Users/alm/UIBK/FLEA5/.build/x86_64-apple-macosx/debug/FLEA5PackageTests.xctest"]
    - swift test --filter BaseTests
      ["-XCTest", "BaseTests.CommandLineTests/testParameters", "/Users/alm/UIBK/FLEA5/.build/x86_64-apple-macosx/debug/FLEA5PackageTests.xctest"]

    */

    func testParameters() {
        print("πars", CL.parameters.count, CL.parameters)

        #if os(macOS)

        switch CL.parameters.count {
        case 3:
            XCTAssertEqual("-XCTest", CL.parameters.first)
            XCTAssertTrue(CL.parameters[1].contains("BaseTests.CommandLineTests"))
            fallthrough
        case 1:
            XCTAssertTrue(CL.parameters.last?.hasSuffix("/FLEA5PackageTests.xctest") ?? false)
        default:
            XCTFail("\(CL.parameters.count) parameters.")
        }
        #endif
    }

    func testOptions() {
        print("πars", CL.parameters.count, CL.parameters)
        print("οpts", CL.options.count, CL.options)

        XCTAssertNotNil(CL.options["•"])

    }
}