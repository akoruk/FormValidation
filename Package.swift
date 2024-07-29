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
    ],
    targets: [
        .target(
            name: "FormValidation"),
        .testTarget(
            name: "FormValidationTests",
            dependencies: ["FormValidation"]),
    ]
)
