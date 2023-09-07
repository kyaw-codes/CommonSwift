// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonSwift",
    platforms: [
        .macOS(.v10_14), .iOS(.v13)
    ],
    products: [
        .library(
            name: "CommonSwift",
            targets: ["CommonSwift"]),
    ],
    targets: [
        .target(
            name: "CommonSwift"
        ),
        .testTarget(
            name: "CommonSwiftTests",
            dependencies: ["CommonSwift"]
        ),
    ]
)
