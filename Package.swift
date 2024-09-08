// swift-tools-version: 5.4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FormValidation",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "FormValidation",
            targets: ["FormValidation"]),
        .executable(
            name: "FormValidation SampleApp",
            targets: ["FormValidation SampleApp"])
    ],
    targets: [
        .target(
            name: "FormValidation"),
        .executableTarget(
            name: "FormValidation SampleApp",
            dependencies: ["FormValidation"],
            path: "Example"),
        .testTarget(
            name: "FormValidationTests",
            dependencies: ["FormValidation"]),
    ]
)
