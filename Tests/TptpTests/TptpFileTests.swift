import Foundation
import Runtime
import XCTest

@testable import Tptp

public class TptpFileTests: XCTestCase {
    let cr = "\n"
    let line = "---------------------------------------------------------------------------------"
    /// set up logging once _before_ all tests of a test class
    public override class func setUp() {}

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {}

    func test_fXz() {
        guard
            let file = Tptp.File(string: "f(X,z)", type: Tptp.SymbolType.variable),
            let root = file.root, let term = root.child, 
            let role = term.child, let predicate = role.sibling,
            let function = predicate.child,
            let X = function.child, let z = X.sibling
        else {
            XCTFail()
            return
        }

        XCTAssertNil(root.sibling)
        XCTAssertNil(term.sibling)
        XCTAssertNil(predicate.sibling)
        XCTAssertNil(function.sibling)
        XCTAssertNil(z.sibling)

        XCTAssertEqual(file.path, "tempTptpFile")

        XCTAssertEqual(root.symbol, "tempTptpFile")
        XCTAssertEqual(Tptp.SymbolType(of: root), .file)

        XCTAssertEqual(term.symbol, "tempTermName")
        XCTAssertEqual(Tptp.SymbolType(of: term), .fof)

        XCTAssertEqual(role.symbol, "axiom")
        XCTAssertEqual(Tptp.SymbolType(of: role), .role)

        XCTAssertEqual(predicate.symbol, "tempTermWrapperPredicate")
        XCTAssertEqual(Tptp.SymbolType(of: predicate), .predicate(1))

        XCTAssertEqual(function.symbol, "f")
        XCTAssertEqual(Tptp.SymbolType(of: function), .function(2))

        XCTAssertEqual(X.symbol, "X")
        XCTAssertEqual(Tptp.SymbolType(of: X), .variable)

        XCTAssertEqual(z.symbol, "z")
        XCTAssertEqual(Tptp.SymbolType(of: z), .function(0))
    }
}

/// PUZ - Puzzles
extension TptpFileTests {

    func testPUZ001m1() {
        print(line+cr+#file.fileName, #function, #line, #column)
        let file = Tptp.File(problem: "PUZ001-1")!

        XCTAssertTrue(file.path!.hasSuffix("TPTP/Problems/PUZ/PUZ001-1.p"))
        XCTAssertTrue(file.root!.symbol!.hasSuffix("TPTP/Problems/PUZ/PUZ001-1.p"))
        XCTAssertEqual(Tptp.SymbolType(of: file.root!), .file)
        for child in file.root!.children {
            XCTAssertEqual(Tptp.SymbolType(of: child), .cnf)
        }
    }

    func testPUZ001p1() {
        print(line+cr+#file.fileName, #function, #line, #column)
        let file = Tptp.File(problem: "PUZ001+1")!

        XCTAssertTrue(file.path!.hasSuffix("TPTP/Problems/PUZ/PUZ001+1.p"))
        XCTAssertTrue(file.root!.symbol!.hasSuffix("TPTP/Problems/PUZ/PUZ001+1.p"))
        XCTAssertEqual(Tptp.SymbolType(of: file.root!), .file)
        for child in file.root!.children {
            XCTAssertEqual(Tptp.SymbolType(of: child), .fof)
        }

        let node = Tptp.Node.create(file: file)!

        print(node, cr+line)
    }

    func testPUZ006m1() {
        print(line+cr+#file.fileName, #function, #line, #column)
        let file = Tptp.File(problem: "PUZ006-1")!

        XCTAssertTrue(file.path!.hasSuffix("TPTP/Problems/PUZ/PUZ006-1.p"))
        XCTAssertTrue(file.root!.symbol!.hasSuffix("TPTP/Problems/PUZ/PUZ006-1.p"))
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
            print(include, cr+line)
        }
    }

}

/// HWV - Hardware verification

extension TptpFileTests {

    func testHWV134m1() {
        print(line+cr+#file.fileName, #function, #line, #column)
        let (_, triple) = Time.measure {
            let file = Tptp.File(problem: "HWV134-1")!

            XCTAssertTrue(file.path!.hasSuffix("TPTP/Problems/HWV/HWV134-1.p"))
            XCTAssertTrue(file.root!.symbol!.hasSuffix("TPTP/Problems/HWV/HWV134-1.p"))
            XCTAssertEqual(Tptp.SymbolType(of: file.root!), .file)
            for child in file.root!.children {
                XCTAssertEqual(Tptp.SymbolType(of: child), .cnf)
            }
        }

        XCTAssertTrue(triple.user + triple.system < triple.absolute)
        XCTAssertTrue(triple.absolute * 0.8 < triple.user + triple.system)

        XCTAssertTrue(triple.user <= 12.0)
        XCTAssertTrue(triple.system <= 3.5)
        XCTAssertTrue(triple.absolute <= 15.5)

        print(triple, cr+line)
    }

}
