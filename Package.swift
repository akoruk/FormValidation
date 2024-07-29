// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FormValidation",
    platforms: [
        .iOS(.v15),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "FormValidation",
            targets: ["FormValidation"]),
        .executable(
            name: "ExampleApp",
            targets: ["ExampleApp"])
    ],
    targets: [
        .target(
            name: "FormValidation"),
        .executableTarget(
            name: "ExampleApp",
            dependencies: ["FormValidation"],
            path: "Examples/ExampleApp"),
        .testTarget(
            name: "FormValidationTests",
            dependencies: ["FormValidation"]),
    ]
)
