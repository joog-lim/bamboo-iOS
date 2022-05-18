// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    products: [
        .library(
            name: "Base",
            targets: ["Base"]),
        .library(
            name: "UIUtil",
            targets: ["UIUtil"]),
        .library(
            name: "RxUtil",
            targets: ["RxUtil"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .branchItem("main")),
        .package(url: "https://github.com/ReactorKit/ReactorKit", .branchItem("master")),
        .package(url: "https://github.com/RxSwiftCommunity/RxFlow", .branchItem("main"))
    ],
    targets: [
        .target(
            name: "Base",
            dependencies: [
                "RxSwift",
                "ReactorKit"
            ]),
        .target(
            name: "UIUtil",
            dependencies: []),
        .target(
            name: "RxUtil",
            dependencies: [
                "RxSwift",
                "RxFlow"
            ]),
    ]
)
