import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Setup project

let project = Project(
  name: appName,
  organizationName: organizationName,
  options: .options(automaticSchemesOptions: .disabled),
  packages: [
    .local(path: .relativeToRoot("\(dependenciesPath)/FancyFoundation")),
    .local(path: .relativeToRoot("\(dependenciesPath)/FancyKit")),
    .local(path: .relativeToRoot("\(dependenciesPath)/FancyNetwork")),
    .local(path: .relativeToRoot("\(dependenciesPath)/FancyNotifications")),
    .local(path: .relativeToRoot("\(dependenciesPath)/FancyStyle")),
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture",
            requirement: .exact("1.4.2"))
  ],
  settings: projectBuildIOSSettings,
  targets: [
    Target(
      name: appName,
      platform: .iOS,
      product: .app,
      bundleId: "\(bundle)",
      deploymentTarget: .iOS(targetVersion: "\(iOSversion)", devices: [.iphone, .ipad]),
      infoPlist: getMainIOSInfoPlist(),
      sources: [
        "\(rootPath)/\(appPath)/Sources/**/*",
      ],
      resources: [
        "\(rootPath)/\(appPath)/Resources/**/*",
      ],
      entitlements: .file(path: .relativeToRoot("\(rootPath)/\(appPath)/Entity/\(appName).entitlements")),
      scripts: [
        scriptSwiftLint
      ],
      dependencies: [
        .package(product: "FancyFoundation"),
        .package(product: "FancyKit"),
        .package(product: "FancyNetwork"),
        .package(product: "FancyNotifications"),
        .package(product: "FancyStyle"),
        .package(product: "ComposableArchitecture", type: .macro)
      ],
      settings: targetBuildIOSSettings
    ),
    Target(
      name: "\(appName)Tests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "\(bundleTest)",
      deploymentTarget: .iOS(targetVersion: "\(iOSversion)", devices: [.iphone, .ipad]),
      infoPlist: .default,
      sources: [
        "\(rootPath)/\(appPath)/Tests/**/*"
      ],
      dependencies: [
        .target(name: "\(appName)")
      ],
      settings: targetBuildTestsSettings
    )
  ],
  schemes: [mainIOSScheme, mainTestsIOSScheme]
)
