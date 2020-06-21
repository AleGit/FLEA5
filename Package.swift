// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension Target {
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
    static func target(module: Module, dependencies: [Module]) -> PackageDescription.Target {
        return .target(name: module.targetName, dependencies: dependencies.map { $0.targetDependency })
    }
    static func testTarget(module: Module, dependencies: [Module]) -> PackageDescription.Target {
        return .testTarget(name: module.testTargetName, dependencies: dependencies.map { $0.targetDependency })
    }
}


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
        .target(module: .flea,   dependencies: [.base, .utile, .tptp]),

        .testTarget(module: .base,   dependencies: [.base]),
        .testTarget(module: .utile,  dependencies: [.utile]),
        .testTarget(module: .tptp,   dependencies: [.tptp]),
        .testTarget(module: .solver, dependencies: [.solver]),
    ]
)
