import XCTest

import BaseTests
import SolverTests
import TptpTests
import UtileTests

var tests = [XCTestCaseEntry]()
tests += BaseTests.__allTests()
tests += SolverTests.__allTests()
tests += TptpTests.__allTests()
tests += UtileTests.__allTests()

XCTMain(tests)
