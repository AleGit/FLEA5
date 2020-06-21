import Foundation
import Runtime
import XCTest
import CTptpParsing

@testable import Tptp

public class FileTests: AbstractTestCase {

    /// set up logging once _before_ all tests of a test class
    public override class func setUp() {
    }

    /// teardown logging once _after_ all tests of a test class
    public override class func tearDown() {
    }

    func test_fXz() {
        let string = "f(X,z)"
        guard
                let file = Tptp.File(string: string, type: Tptp.SymbolType.variable, name: "tempTptpFile"),
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
extension FileTests {

    func testPUZ001m1() {
        guard let file = Tptp.File(problem: "PUZ001-1") ,
              let filePath = file.path, let root = file.root,
              let rootSymbol = root.symbol else {
            XCTFail()
            return
        }
        XCTAssertTrue(filePath.hasSuffix("TPTP/Problems/PUZ/PUZ001-1.p"))
        XCTAssertTrue(rootSymbol.hasSuffix("TPTP/Problems/PUZ/PUZ001-1.p"))

        XCTAssertEqual(Tptp.SymbolType(of: root), .file)

        for child in root.children {
            XCTAssertEqual(PRLC_CNF, child.type)
            XCTAssertEqual(Tptp.SymbolType(of: child), .cnf)
        }
    }

    func testPUZ001p1() {
        let problemName = "PUZ001+1"

        guard let file1 = Tptp.File(problem: problemName),
              let node1 = Tptp.Term.create(file: file1) else {
            XCTFail(problemName)
            return
        }
        print(1, "•", node1.symbol)

        XCTAssertTrue(file1.path!.hasSuffix("TPTP/Problems/PUZ/PUZ001+1.p"))
        XCTAssertTrue(file1.root!.symbol!.hasSuffix("TPTP/Problems/PUZ/PUZ001+1.p"))
        XCTAssertEqual(Tptp.SymbolType(of: file1.root!), .file)
        for child in file1.root!.children {
            XCTAssertEqual(Tptp.SymbolType(of: child), .fof)
        }

        let urlString = "http://www.tptp.org/cgi-bin/SeeTPTP?Category=Problems&Domain=PUZ&File=PUZ001+1.p"
        // let urlString = "file:///Users/alm/TPTP/Problems/PUZ/PUZ001+1.p"
        guard let url = URL(string: urlString),
              let file2 = Tptp.File(url: url),
              let node2 = Tptp.Term.create(file: file2) else {
            XCTFail(urlString)
            return
        }
        print(2, "•", node2.symbol)



        XCTAssertEqual(node1.nodes, node2.nodes)

        // assert node 1





    }

    func testPUZ006m1() {
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
            print(#function, "•", include)
        }
    }

}

/// HWV - Hardware verification

extension FileTests {

    func _testHWV134m1() {
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

        XCTAssertTrue(triple.user <= 15.0)
        XCTAssertTrue(triple.system <= 5.5)
        XCTAssertTrue(triple.absolute <= 20.5)
    }

}
