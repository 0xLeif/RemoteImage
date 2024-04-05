// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteImage",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "RemoteImage",
            targets: ["RemoteImage"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/0xLeif/AppState.git", from: "1.0.0"),
        .package(url: "https://github.com/0xLeif/Network.git", from: "1.0.0"),
        .package(url: "https://github.com/0xLeif/Waiter.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "RemoteImage",
            dependencies: [
                "AppState",
                "Network"
            ]
        ),
        .testTarget(
            name: "RemoteImageTests",
            dependencies: [
                "RemoteImage",
                "Waiter"
            ]
        )
    ]
)
