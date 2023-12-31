// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FancyKit",
  platforms: [.iOS(.v16)],
  products: [
    .library(
      name: "FancyKit",
      targets: ["FancyKit"]
    ),
  ],
  dependencies: [
    .package(path: "Dependencies/FancyStyle")
  ],
  targets: [
    .target(
      name: "FancyKit",
      dependencies: [
        .product(name: "FancyStyle", package: "FancyStyle")
      ]
    ),
  ]
)
