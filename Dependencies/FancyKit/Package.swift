// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FancyKit",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "FancyKit",
      targets: ["FancyKit"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "FancyKit",
      dependencies: []
    ),
  ]
)