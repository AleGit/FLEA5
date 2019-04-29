import Foundation
import XCTest

@testable import Tptp

public class TptpFileTests: XCTestCase {

    /// set up logging once _before_ all tests of a test class
    public override class func setUp() {
        
    }

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {
        
    }

    func testPUZ001m1() {
        let file = Tptp.File(problem:"PUZ001-1")! 

        XCTAssertTrue(file.path!.hasSuffix("TPTP/Problems/PUZ/PUZ001-1.p") )
        XCTAssertTrue(file.root!.symbol!.hasSuffix("TPTP/Problems/PUZ/PUZ001-1.p") )
        XCTAssertEqual(Tptp.SymbolType(of: file.root!), .file)
        for child in file.root!.children {
            XCTAssertEqual(Tptp.SymbolType(of: child), .cnf)
        }
    }

    func testPUZ006m1() {
        let file = Tptp.File(problem:"PUZ006-1")! 

        XCTAssertTrue(file.path!.hasSuffix("TPTP/Problems/PUZ/PUZ006-1.p") )
        XCTAssertTrue(file.root!.symbol!.hasSuffix("TPTP/Problems/PUZ/PUZ006-1.p") )
        XCTAssertEqual(Tptp.SymbolType(of: file.root!), .file)
        for child in file.root!.children {
            let type = Tptp.SymbolType(of: child)
            switch type {
                case .include:
                XCTAssertEqual(child.symbol!, "'Axioms/PUZ001-0.ax'")

                default:
                XCTAssertEqual(type, .cnf)
            }
        }

        let includes = file.includeSelectionURLTriples(url: file.url!)
        for include in includes {
            print(include)
        }
    }

    func testHWV134m1() {
        let file = Tptp.File(problem:"HWV134-1")! 

        XCTAssertTrue(file.path!.hasSuffix("TPTP/Problems/HWV/HWV134-1.p") )
        XCTAssertTrue(file.root!.symbol!.hasSuffix("TPTP/Problems/HWV/HWV134-1.p") )
        XCTAssertEqual(Tptp.SymbolType(of: file.root!), .file)
        for child in file.root!.children {
            XCTAssertEqual(Tptp.SymbolType(of: child), .cnf)
        }
    }

    func testPUZ001p1() {
        let file = Tptp.File(problem:"PUZ001+1")! 

        XCTAssertTrue(file.path!.hasSuffix("TPTP/Problems/PUZ/PUZ001+1.p") )
        XCTAssertTrue(file.root!.symbol!.hasSuffix("TPTP/Problems/PUZ/PUZ001+1.p") )
        XCTAssertEqual(Tptp.SymbolType(of: file.root!), .file)
        for child in file.root!.children {
            XCTAssertEqual(Tptp.SymbolType(of: child), .fof)
        }
    }
}