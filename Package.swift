// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWCollectionViewLayout",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWCollectionViewLayout", targets: ["WWCollectionViewLayout"]),
    ],
    targets: [
        .target(name: "WWCollectionViewLayout", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
