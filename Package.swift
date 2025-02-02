// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "PhoneticTextSwift",
    platforms: [
        .iOS(.v14),
        .macOS(.v13),
        .macCatalyst(.v13),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "PhoneticTextSwift",
            targets: ["PhoneticTextSwift"]
        )
    ],
    targets: [
        .target(
            name: "PhoneticTextSwift",
            dependencies: []
        ),
        .testTarget(
            name: "PhoneticTextSwiftTests",
            dependencies: ["PhoneticTextSwift"]
        )
    ]
)
