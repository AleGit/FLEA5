// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/** __Dependency directed down graph:__
```
         flea
            \
        solver
       /  /   \
    z3 yices  tptp
             /  \
      parsing  utile
                  \
                  base
```
*/
let package: Package = Package(
    name: "FLEA5",
    dependencies: [
        // Dependencies declare other packages that this package depends on.

        .package(url:"https://github.com/AleGit/CTptpParsing.git", from: "1.0.0" ),
        .package(url:"https://github.com/AleGit/CYices.git", from: "1.0.0" ),
        .package(url:"https://github.com/AleGit/CZ3API.git", from: "1.0.0" )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.

        .target(module: .base,   dependencies: []),
        .target(module: .utile,  dependencies: [.base]),
        .target(module: .tptp,   dependencies: [.utile]),
        .target(module: .solver, dependencies: [.tptp]),
        .target(module: .flea,   dependencies: [.solver]),

        // implicit test suite names and dependencies

        .testTarget(module: .base),
        .testTarget(module: .utile),
        .testTarget(module: .tptp),
        .testTarget(module: .solver),
    ]
)

extension Target {
    /// Since string literals are used multiple times for names and dependencies
    /// we introduce module enum values for all our modules and test suits
    /// to avoid typos and enables easier renaming.
    enum Module: String {
        case base   = "Base"   // extensions of Foundation and swift standard library
        case utile  = "Utile"  // protocols and structs ("abstract data types")
        case tptp   = "Tptp"   // parsing and data structures for tptp files
        case solver = "Solver" // proving with yices and z3
        case flea   = "Flea"   // command line program definition

        /// the name of this module
        var targetName: String { self.rawValue }
        /// the name of the test suite for this module
        var testTargetName: String { self.targetName + "Tests" }
        /// a dependency on this module (by an other module or test suite)
        var dependency: Dependency { Dependency(stringLiteral: self.rawValue) }
    }

    /// Factory method that uses module enum values for name and dependencies of a module.
    /// - Parameters:
    ///   - module: the module enum value
    ///   - dependencies: the packages the module is dependent on
    /// - Returns: a regular package description build target
    static func target(module: Module, dependencies: [Module]) -> PackageDescription.Target {
        return .target(name: module.targetName, dependencies: dependencies.map { $0.dependency })
    }

    /// Factory method that uses module enum values for name and dependencies of a test suite.
    /// By default a test suite "FooTests" is created with dependency on module "Foo".
    /// A test suite must not depend on other test suites.
    /// - Parameters:
    ///   - module: the module enum value the test suite is for
    ///   - dependencies: the packages the test suite is dependent on
    /// - Returns: a test package description target
    static func testTarget(module: Module, dependencies: [Module]? = nil) -> PackageDescription.Target {
        guard let dependencies = dependencies else {
            // implicit test suit name, implicit dependency on one module, e.g. FooTests -> [Foo]
            return .testTarget(name: module.testTargetName, dependencies: [module.dependency])
        }
        // implicit test suite name, explicit dependency none, one or more modules, e.g. FooTests -> [Foo, Bar]
        return .testTarget(name: module.testTargetName, dependencies: dependencies.map { $0.dependency} )
    }
}
