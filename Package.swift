// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "BaxSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BaxSDK",
            targets: ["BaxSDK"]
        ),
    ],
    targets: [
        .target(
            name: "BaxSDK",
            dependencies: [],
            path: "Sources/BaxSDK"
        ),
        .testTarget(
            name: "BaxSDK_tests",
            dependencies: ["BaxSDK"],
            path: "Tests/BaxSDKTests"
        ),
    ]
)
