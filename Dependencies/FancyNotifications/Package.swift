// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FancyNotifications",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "FancyNotifications",
      targets: ["FancyNotifications"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "FancyNotifications",
      dependencies: []
    )
  ]
)
