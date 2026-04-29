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
        ),
        .library(
            name: "ChromeWheelRouterMac",
            targets: ["ChromeWheelRouterMac"]
        ),
        .executable(
            name: "ChromeWheelRouterCLI",
            targets: ["ChromeWheelRouterCLI"]
        )
    ],
    targets: [
        .target(
            name: "ChromeWheelRouterCore"
        ),
        .target(
            name: "ChromeWheelRouterMac",
            dependencies: ["ChromeWheelRouterCore"]
        ),
        .executableTarget(
            name: "ChromeWheelRouterCLI",
            dependencies: ["ChromeWheelRouterCore", "ChromeWheelRouterMac"]
        ),
        .testTarget(
            name: "ChromeWheelRouterCoreTests",
            dependencies: ["ChromeWheelRouterCore"]
        )
    ]
)
