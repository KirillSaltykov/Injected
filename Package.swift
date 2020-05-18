// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Injected",
    products: [
        .library(
            name: "Injected",
            targets: ["Injected"]),
    ],
    targets: [
        .target(
            name: "Injected",
            dependencies: []),
        .testTarget(
            name: "InjectedTests",
            dependencies: ["Injected"]),
    ]
)
