// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "hdxl-toolbox",
  platforms: [
    .iOS(.v18),
    .macOS(.v15),
    .tvOS(.v18),
    .watchOS(.v11)
  ],
  products: [
    .library(
      name: "HDXLToolbox",
      targets: [
        "HDXLCollectionSupport"
      ]
    )
  ],
  dependencies: [
  ],
  targets: [
    .target(
        name: "HDXLCollectionSupport",
        dependencies: []
    ),
    .testTarget(
        name: "HDXLCollectionSupportTests",
        dependencies: ["HDXLCollectionSupport"]
    )
  ],
  swiftLanguageVersions: [
    .v6
  ]
)
