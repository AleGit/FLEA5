import XCTest

import AlgorithmsTests
import ArgumentParserTests
import BaseTests
import LoggingTests
import SolverTests
import TptpTests
import UtileTests

var tests = [XCTestCaseEntry]()
tests += AlgorithmsTests.__allTests()
tests += ArgumentParserTests.__allTests()
tests += BaseTests.__allTests()
tests += LoggingTests.__allTests()
tests += SolverTests.__allTests()
tests += TptpTests.__allTests()
tests += UtileTests.__allTests()

XCTMain(tests)
