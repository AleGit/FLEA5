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
        .target(name: "Runtime", dependencies: []),
        .target(name: "Tree", dependencies: []),
        .target(name: "Tptp", dependencies: ["Runtime", "Tree"]),
        .target(name: "Solver", dependencies: ["Runtime", "Tree", "Tptp"]),
        .target(name: "Flea", dependencies: ["Runtime", "Tree", "Tptp", "Solver"]),
        .testTarget(name: "RuntimeTests", dependencies: ["Runtime"]),
        .testTarget(name: "TptpTests", dependencies: ["Tptp"]),
        .testTarget(name: "SolverTests", dependencies: ["Solver"]),
        // .testTarget(name: "FleaTests", dependencies: ["FleaCmd"])
    ]
)
