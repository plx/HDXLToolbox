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
        "HDXLObjectCollections",
        "HDXLSemanticEquivalence",
        "HDXLUtilityCollections"
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
    // for documentation-rendering support
    .package(
      url: "https://github.com/apple/swift-docc-plugin",
      from: "1.3.0"
    ),
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
      name: "HDXLUtilityCollections",
      dependencies: [
        "HDXLEssentialPrecursors",
        "HDXLCollectionSupport"
      ]
    ),
    .testTarget(
      name: "HDXLUtilityCollectionsTests",
      dependencies: [
        "HDXLTestingSupport",
        "HDXLUtilityCollections"
      ]
    ),

    .target(
      name: "HDXLSemanticEquivalence",
      dependencies: [
        "HDXLEssentialPrecursors",
        "HDXLObjectCollections"
      ]
    ),
    .testTarget(
      name: "HDXLSemanticEquivalenceTests",
      dependencies: [
        "HDXLTestingSupport",
        "HDXLSemanticEquivalence"
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
        "HDXLTestingSupport",
        "HDXLCollectionSupport"
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
