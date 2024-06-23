// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

// MARK: Macro-Related Dependencies

let macroPluginDependencies: [Target.Dependency] = [
  .product(
    name: "SwiftSyntax",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftParser",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftSyntaxBuilder",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftSyntaxMacros",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftCompilerPlugin",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftDiagnostics",
    package: "swift-syntax"
  )
]

let macroLibraryDependencies: [Target.Dependency] = [
  .product(
    name: "SwiftSyntax",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftParser",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftSyntaxBuilder",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftSyntaxMacros",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftDiagnostics",
    package: "swift-syntax"
  )
]

let macroSupportDependencies: [Target.Dependency] = [
  .product(
    name: "SwiftSyntax",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftParser",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftSyntaxBuilder",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftSyntaxMacros",
    package: "swift-syntax"
  ),
  .product(
    name: "SwiftDiagnostics",
    package: "swift-syntax"
  )
]




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
        "HDXLKeyedCollections",
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
    ),
  
    .library(
      name: "HDXLEssentialMacros",
      targets: ["HDXLEssentialMacros"]
    ),
    .executable(
      name: "HDXLEssentialMacrosClient",
      targets: ["HDXLEssentialMacrosClient"]
    ),
  ],
  dependencies: [
    // for documentation-rendering support
    .package(
      url: "https://github.com/apple/swift-docc-plugin",
      from: "1.3.0"
    ),
    .package(
      url: "https://github.com/apple/swift-syntax.git",
      from: "510.0.0"
      //      from: "510.0.0"
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
      name: "HDXLAlgebraicTypes",
      dependencies: [
        "HDXLEssentialPrecursors",
        "HDXLEssentialMacros"
      ]
    ),
    .target(
      name: "HDXLAlgebraicTypesTestSupport",
      dependencies: [
        "HDXLTestingSupport",
        "HDXLAlgebraicTypes",
        "HDXLUtilityCollections"
      ]
    ),
    .testTarget(
      name: "HDXLAlgebraicTypesTests",
      dependencies: [
        "HDXLTestingSupport",
        "HDXLAlgebraicTypes",
        "HDXLAlgebraicTypesTestSupport"
      ]
    ),
    
    .target(
      name: "HDXLKeyedCollections",
      dependencies: [
        "HDXLEssentialPrecursors",
        "HDXLCollectionSupport"
      ]
    ),
    .testTarget(
      name: "HDXLKeyedCollectionsTests",
      dependencies: [
        "HDXLTestingSupport",
        "HDXLKeyedCollections"
      ]
    ),
    
    .target(
      name: "HDXLUtilityCollections",
      dependencies: [
        "HDXLEssentialPrecursors",
        "HDXLEssentialMacros",
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
        "HDXLObjectCollections",
        "HDXLUtilityCollections"
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
      dependencies: [
        "HDXLAlgebraicTypes"
      ]
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
          "HDXLEssentialPrecursors",
          "HDXLKeyedCollections"
        ]
      ),
    .testTarget(
      name: "HDXLTestingSupportTests",
      dependencies: [
        "HDXLTestingSupport"
      ]
    ),
    
    .target(
      name: "HDXLMacroSupport",
      dependencies: [
        "HDXLEssentialPrecursors",
        .product(
          name: "SwiftSyntax",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftParser",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftSyntaxBuilder",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftSyntaxMacros",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftDiagnostics",
          package: "swift-syntax"
        )
      ]
    ),
    .target(
      name: "HDXLEssentialMacros",
      dependencies: [
        "HDXLEssentialPrecursors",
        "HDXLMacroSupport",
        "HDXLEssentialMacrosPlugin",
        .product(
          name: "SwiftSyntax",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftParser",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftSyntaxBuilder",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftSyntaxMacros",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftDiagnostics",
          package: "swift-syntax"
        )
      ]
    ),
    .macro(
      name: "HDXLEssentialMacrosPlugin",
      dependencies: [
        "HDXLEssentialPrecursors",
        "HDXLMacroSupport",
        .product(
          name: "SwiftSyntax",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftParser",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftSyntaxBuilder",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftSyntaxMacros",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftCompilerPlugin",
          package: "swift-syntax"
        ),
        .product(
          name: "SwiftDiagnostics",
          package: "swift-syntax"
        )
      ]
    ),
    .executableTarget(
      name: "HDXLEssentialMacrosClient",
      dependencies: [
        "HDXLEssentialMacros",
        "HDXLEssentialPrecursors",
        "HDXLMacroSupport"
      ]
    ),
  ],
  swiftLanguageVersions: [
    .v6
  ]
)

