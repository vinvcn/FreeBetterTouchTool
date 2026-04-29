// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ChromeWheelRouter",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "ChromeWheelRouterCore",
            targets: ["ChromeWheelRouterCore"]
        )
    ],
    targets: [
        .target(
            name: "ChromeWheelRouterCore"
        ),
        .testTarget(
            name: "ChromeWheelRouterCoreTests",
            dependencies: ["ChromeWheelRouterCore"]
        )
    ]
)
