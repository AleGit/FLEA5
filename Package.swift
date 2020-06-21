// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
        .target(module: .tptp,   dependencies: [.base, .utile]),
        .target(module: .solver, dependencies: [.base, .utile, .tptp]),
        .target(module: .flea,   dependencies: [.base, .utile, .tptp, .solver]),

        .testTarget(module: .base),
        .testTarget(module: .utile),
        .testTarget(module: .tptp),
        .testTarget(module: .solver),
    ]
)



extension Target {
    /// Since literal strings are used multiple times for names and dependencies
    /// we introduce module enum values for all our modules and test suits.
    enum Module: String {
        case base = "Base"
        case utile = "Utile"
        case tptp = "Tptp"
        case solver = "Solver"
        case flea = "Flea"

        var targetName: String {
            self.rawValue
        }
        var testTargetName: String {
            self.targetName + "Tests"
        }
        var targetDependency : Target.Dependency {
            Target.Dependency.init(stringLiteral: self.rawValue)
        }
    }
    /// We introduce a factory method that uses module enum values for name and dependencies of a module.
    static func target(module: Module, dependencies: [Module]) -> PackageDescription.Target {
        return .target(name: module.targetName, dependencies: dependencies.map { $0.targetDependency })
    }
    /// We introduce a factory method that uses module enum values for name and dependencies of a test suite.
    /// By convention we create for module "Foo" a test suite "FooTests" depending on module "Foo".
    /// We must not create a test suite depending on an other test suite.
    static func testTarget(module: Module, dependencies: [Module]? = nil) -> PackageDescription.Target {
        guard let dependencies = dependencies else {
            // implicit test suit name, implicit dependency on one module
            return .testTarget(name: module.testTargetName, dependencies: [module.targetDependency])
        }
        // implicit test suite name, explicit dependency none, one or more modules
        return .testTarget(name: module.testTargetName, dependencies: dependencies.map { $0.targetDependency} )
    }
}
