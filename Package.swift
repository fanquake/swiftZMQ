// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "swiftZMQ",
    products: [
        .library(
            name: "swiftZMQ",
            targets: ["swiftZMQ"]),
    ],
    dependencies: [],
    targets: [
        .systemLibrary(
            name: "zeromq",
            pkgConfig: "libzmq",
            providers: [
                .brew(["zeromq"])
            ]),
        .target(
            name: "swiftZMQ",
            dependencies: ["zeromq"]),
        .testTarget(
            name: "swiftZMQTests",
            dependencies: ["swiftZMQ"]),
    ]
)
