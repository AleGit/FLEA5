import Foundation
import Runtime
import XCTest
import CTptpParsing

@testable import Tptp

public class ProblemTests: XCTestCase {

    func testPUZ001m1() {
        guard let file = Tptp.File(problem: "PUZ001-1"),
              let node = Tptp.Node.create(file: file),
              let nodes = node.nodes else {
            XCTFail()
            return
        }

        XCTAssertTrue(node.symbol.hasSuffix("/PUZ/PUZ001-1.p"))

        for child in nodes {
            XCTAssertEqual(PRLC_CNF, child.type, child.description)

            guard let cnf_formula = child.nodes?[1] else {
                XCTFail()
                return
            }
            XCTAssertEqual("|", cnf_formula.symbol, cnf_formula.description)
            XCTAssertEqual(PRLC_CONNECTIVE, cnf_formula.type, cnf_formula.description)
        }

        print(node)
    }

    func _testHWV134m1() {
        guard let tptpFile = Tptp.File(problem: "HWV134-1"),
              let tptpFileNode = Tptp.Node.create(file: tptpFile),
              let nodes = tptpFileNode.nodes else {
            XCTFail()
            return
        }



        XCTAssertTrue(tptpFileNode.symbol.hasSuffix("/HWV/HWV134-1.p"))

        for annotatedFormula in nodes {
            XCTAssertEqual(PRLC_CNF, annotatedFormula.type, annotatedFormula.symbol)

            guard let cnf_formula = annotatedFormula.nodes?.last else {
                XCTFail()
                return
            }
            XCTAssertEqual("|", cnf_formula.symbol)
            XCTAssertEqual(PRLC_CONNECTIVE, cnf_formula.type)
        }
    }
}
