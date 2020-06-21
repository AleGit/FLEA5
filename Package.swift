// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription



extension Target {
    enum Modules: String {

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
    static func target(name: Modules, dependencies: [Modules]) -> PackageDescription.Target {
        return .target(name: name.targetName, dependencies: dependencies.map { $0.targetDependency })
    }
    static func testTarget(name: Modules, dependencies: [Modules]) -> PackageDescription.Target {
        return .testTarget(name: name.testTargetName, dependencies: dependencies.map { $0.targetDependency })
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

        .target(name: .base,   dependencies: []),
        .target(name: .utile,  dependencies: [.base]),
        .target(name: .tptp,   dependencies: [.base, .utile]),
        .target(name: .solver, dependencies: [.base, .utile, .tptp]),
        .target(name: .flea,   dependencies: [.base, .utile, .tptp]),

        .testTarget(name: .base,   dependencies: [.base]),
        .testTarget(name: .utile,  dependencies: [.utile]),
        .testTarget(name: .tptp,   dependencies: [.tptp]),
        .testTarget(name: .solver, dependencies: [.solver]),
    ]
)
