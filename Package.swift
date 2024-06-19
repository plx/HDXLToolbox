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
        "HDXLSerialization",
        "HDXLObjectCollections"
      ]
    ),
    
    .library(
      name: "HDXLTestingSupport",
      targets: [
        "HDXLTestingSupport"
      ]
    )
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "HDXLEssentialPrecursors",
      dependencies: []
    ),
    .testTarget(
      name: "HDXLEssentialPrecursorsTests",
      dependencies: [
        "HDXLTestingSupport",
        "HDXLEssentialPrecursors"
      ]
    ),
    
    .target(
        name: "HDXLCollectionSupport",
        dependencies: []
    ),
    .testTarget(
        name: "HDXLCollectionSupportTests",
        dependencies: [
          "HDXLCollectionSupport"
        ]
    ),
    
    .target(
      name: "HDXLCollectionValidation",
      dependencies: [
        "HDXLTestingSupport",
        "HDXLEssentialPrecursors"
      ]
    ),
    .testTarget(
      name: "HDXLCollectionValidationTests",
      dependencies: [
        "HDXLCollectionValidation"
      ]
    ),

    .target(
      name: "HDXLObjectCollections",
      dependencies: [
        "HDXLCollectionSupport",
        "HDXLEssentialPrecursors"
      ]
    ),
    .testTarget(
      name: "HDXLObjectCollectionsTests",
      dependencies: [
        "HDXLObjectCollections"
      ]
    ),

    .target(
      name: "HDXLSerialization",
      dependencies: [
        "HDXLEssentialPrecursors"
      ]
    ),
    .target(
      name: "HDXLSerializationTestSupport",
      dependencies: [
        "HDXLSerialization",
        "HDXLTestingSupport"
      ]
    ),
    .testTarget(
      name: "HDXLSerializationTests",
      dependencies: [
        "HDXLSerialization",
        "HDXLTestingSupport",
        "HDXLSerializationTestSupport",
      ]
    ),

    .target(
      name: "HDXLTestingSupport",
      dependencies: [
        "HDXLEssentialPrecursors"
      ]
    ),
    .testTarget(
      name: "HDXLTestingSupportTests",
      dependencies: [
        "HDXLTestingSupport"
      ]
    )
  ],
  swiftLanguageVersions: [
    .v6
  ]
)
