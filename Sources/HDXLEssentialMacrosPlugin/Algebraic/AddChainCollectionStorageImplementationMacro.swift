import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public protocol ChainCollectionStorageMemberMacro: MemberMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax]
}

extension ChainCollectionStorageMemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard
      let classDeclaration = declaration.as(ClassDeclSyntax.self)
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }
    
    guard
      let genericParameters = classDeclaration.simpleGenericParameterNames,
      !genericParameters.isEmpty
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }
    
    return try expansion(
      of: node,
      providingMembersOf: declaration,
      conformingTo: protocols,
      in: context,
      genericParameters: genericParameters
    )
  }
}

public struct AddChainCollectionStorageImplementationMacro { }

extension AddChainCollectionStorageImplementationMacro: ExtensionMacro {

  package static func provideMinMaxExtension(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)CollectionStorage where Element: Comparable {
      
        @inlinable
        internal func min() -> Element? {
          possibleMinimum(
            \(raw: genericParameters.map { "\($0.lowercased()).min()" }.joined(separator: ",\n"))
          )
        }
        
        @inlinable
        internal func max() -> Element? {
          possibleMaximum(
            \(raw: genericParameters.map { "\($0.lowercased()).max()" }.joined(separator: ",\n"))
          )
        }
      
      }
      """
    )
  }
  
  package static func provideContainsExtension(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)CollectionStorage where Element: Equatable {
      
        @inlinable
        internal func contains(_ element: Element) -> Bool {
          anyAreTrue(
            \(raw: genericParameters.map { "\($0.lowercased()).contains(element)" }.joined(separator: ",\n"))
          )
        }

      }
      """
    )
  }

  package static func provideBidirectionalNavigationExtension(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    let positionRetreatCases = genericParameters
      .map { parameter in
        """
        case .\(parameter.lowercased())(let \(parameter.lowercased())Index):
          guard
            let previous\(parameter)Index = $\(parameter.lowercased()).subscriptableIndex(
              before: \(parameter.lowercased())Index
          )
        else {
          return finalPositionBefore\(parameter)
        }
        return .\(parameter.lowercased())(previous\(parameter)Index)
        """
      }
    
    return try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)CollectionStorage
      where
      \(raw: genericParameters.map { "\($0): BidirectionalCollection"}.joined(separator: ",\n"))
      {
      
        @usableFromInline
        internal func position(before position: Position) -> Position? {
          switch position {
          \(raw: positionRetreatCases.joined(separator: "\n"))
          }
        }
      }
      """
    )
  }

  package static func provideUncheckedSendableExtension(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)CollectionStorage: @unchecked Sendable
      where
      \(raw: genericParameters.map { "\($0): Sendable"}.joined(separator: ",\n"))
      { }
      """
    )
  }

  package static func provideEquatableExtension(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    let typeName = "Chain\(genericParameters.count)CollectionStorage<\(genericParameters.joined(separator: ", "))>"
    
    return try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)CollectionStorage: Equatable
      where
      \(raw: genericParameters.map { "\($0): Equatable"}.joined(separator: ",\n"))
      {
      
        @inlinable
        internal static func ==(
          lhs: \(raw: typeName),
          rhs: \(raw: typeName)
        ) -> Bool {
          lhs === rhs
          ||
          lhs.algebraicProductRepresentation == rhs.algebraicProductRepresentation
        }
      }
      """
    )
  }

  package static func provideEncodableExtension(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)CollectionStorage: Encodable
      where
      \(raw: genericParameters.map { "\($0): Encodable"}.joined(separator: ",\n"))
      {
      
        @inlinable
        internal func encode(to encoder: Encoder) throws {
          var container = encoder.singleValueContainer()
          try container.encode(algebraicProductRepresentation)
        }

      }
      """
    )
  }

  package static func provideDecodableExtension(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)CollectionStorage: Decodable
      where
      \(raw: genericParameters.map { "\($0): Decodable"}.joined(separator: ",\n"))
      {
      
        @inlinable
        internal convenience init(from decoder: Decoder) throws {
          let container = try decoder.singleValueContainer()
          self.init(
            algebraicProductRepresentation: try container.decode(
              AlgebraicProductRepresentation.self
            )
          )
        }

      }
      """
    )
  }

  package static func provideHashableExtension(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)CollectionStorage: Hashable
      where
      \(raw: genericParameters.map { "\($0): Hashable"}.joined(separator: ",\n"))
      {
      
        @inlinable
        internal func hash(into hasher: inout Hasher) {
          algebraicProductRepresentation.hash(into: &hasher)
        }
      
      }
      """
    )
  }

  package static func provideCloneableObjectExtension(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)CollectionStorage: CloneableObject {
      
        @inlinable
        internal func obtainClone() -> Self {
          Self(
            \(raw: genericParameters.map { "\($0.lowercased())"}.joined(separator: ",\n"))
          )
        }
      
      }
      """
    )
  }

  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    guard
      let classDeclaration = declaration.as(ClassDeclSyntax.self)
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }
    
    guard
      let genericParameters = classDeclaration.simpleGenericParameterNames,
      !genericParameters.isEmpty
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }
    
    return [
//      try provideUncheckedSendableExtension(
//        of: node,
//        attachedTo: declaration,
//        providingExtensionsOf: type,
//        conformingTo: protocols,
//        in: context,
//        genericParameters: genericParameters
//      ),
      try provideMinMaxExtension(
        of: node,
        attachedTo: declaration,
        providingExtensionsOf: type,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      ),
      try provideContainsExtension(
        of: node,
        attachedTo: declaration,
        providingExtensionsOf: type,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      ),
      try provideEquatableExtension(
        of: node,
        attachedTo: declaration,
        providingExtensionsOf: type,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      ),
      try provideHashableExtension(
        of: node,
        attachedTo: declaration,
        providingExtensionsOf: type,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      ),
      try provideEncodableExtension(
        of: node,
        attachedTo: declaration,
        providingExtensionsOf: type,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      ),
      try provideDecodableExtension(
        of: node,
        attachedTo: declaration,
        providingExtensionsOf: type,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      ),
      try provideBidirectionalNavigationExtension(
        of: node,
        attachedTo: declaration,
        providingExtensionsOf: type,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      ),
      try provideCloneableObjectExtension(
        of: node,
        attachedTo: declaration,
        providingExtensionsOf: type,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    ]
  }

}

public struct AddFixedChainCollectionStorageComponentsMacro: ChainCollectionStorageMemberMacro {
  static func provideConstituentTupleAndAlgebraicProductRepresentation(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    
    return [
      """
      @usableFromInline
      internal typealias ConstituentTuple = (\(raw: genericParameters.joined(separator: ", ")))
      """,
      
      """
      @inlinable
      internal var constituentTuple: ConstituentTuple {
        (\(raw: genericParameters.map { $0.lowercased() }.joined(separator: ", ")))
      }
      """,
      
      """
      @inlinable
      internal convenience init(constituentTuple: ConstituentTuple) {
        self.init(
          \(raw: (0..<genericParameters.count).map { "constituentTuple.\($0)" }.joined(separator: ",\n"))
        )
      }
      """,
      
      """
      @usableFromInline
      internal typealias AlgebraicProductRepresentation = InlineProduct\(raw: genericParameters.count)<\(raw: genericParameters.joined(separator: ", "))>
      """,
      
      """
      @inlinable
      internal var algebraicProductRepresentation: AlgebraicProductRepresentation {
        AlgebraicProductRepresentation(
          tupleRepresentation: constituentTuple
        )
      }
      """,
      
      """
      @inlinable
      internal convenience init(algebraicProductRepresentation: AlgebraicProductRepresentation) {
        self.init(constituentTuple: algebraicProductRepresentation.tupleRepresentation)
      }
      """,
      
      """
      @inlinable
      internal func withMutatedAlgebraicProductRepresentation(
        _ mutation: (inout AlgebraicProductRepresentation) throws -> Void
      ) rethrows -> Self {
        var clone = algebraicProductRepresentation
        try mutation(&clone)
        
        return Self(algebraicProductRepresentation: clone)
      }
      """
    ]
  }

  static func provideExtremalPositions(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    return [
      """
      @usableFromInline
      @ResettableLazyCalculation
      internal func calculateFirstPosition() -> Position? {
        Position.firstNonNil(
          \(raw: genericParameters.map { "$\($0.lowercased()).firstSubscriptableIndex" }.joined(separator: ", \n"))
        )
      }
      """,
      """
      
      @usableFromInline
      @ResettableLazyCalculation
      internal func calculateFinalPosition() -> Position? {
      // recall: lazy evaluation, last-to-first
        Position.finalNonNil(
          \(raw: genericParameters.map { "$\($0.lowercased()).finalSubscriptableIndex" }.joined(separator: ", \n"))
        )
      }
      """
    ]
  }
  
  static func providePositionLinearization(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    
    let positionToLinearizationCases = genericParameters
      .map { parameter in
        """
        case .\(parameter.lowercased())(let \(parameter.lowercased())Index):
          rangeFor\(parameter).lowerBound
          +
          \(parameter.lowercased()).distance(
            from: \(parameter.lowercased()).startIndex,
            to: \(parameter.lowercased())Index
          )
        """
      }
    
    let linearizationToPositionBranches = genericParameters
      .map { parameter in
        """
        if rangeFor\(parameter).contains(linearPosition) {
          return .\(parameter.lowercased())(
            self.\(parameter.lowercased()).index(
              self.\(parameter.lowercased()).startIndex,
              offsetBy: linearPosition - self.rangeFor\(parameter).lowerBound
            )
          )
        }
        """
      } + [
        """
        {
          preconditionFailure(
            \"""
            Attempted to obtain position for out-of-bounds `linearPosition` \\(linearPosition) in \\(String(reflecting: self))!
            \"""
          )
        }
        """
      ]
    
    return [
      """
      @inlinable
      internal func position(forLinearPosition linearPosition: Int) -> Position {
        \(raw: linearizationToPositionBranches.joined(separator: " else "))
      }
      """,
      """
      @inlinable
      internal func linearPosition(forPosition position: Position) -> Int {
        switch position {
        \(raw: positionToLinearizationCases.joined(separator: "\n"))
        }
      }
      """
    ]
  }
  
  static func provideIsEmptyAndCount(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    return [
      """
      @inlinable
      @ResettableLazyCalculation
      internal func calculateIsEmpty() -> Bool {
          allAreEmpty(in: constituentTuple)
      }
      """,
      """
      @inlinable
      @ResettableLazyCalculation
      internal func calculateCount() -> Int {
        switch isEmpty {
        case true:
          0
        case false:
          totalCount(in: constituentTuple)
        }
      }
      """
    ]
  }
  
  static func provideResetCaches(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    return [
      """
      @inlinable
      internal func resetCaches() {
        _isEmpty = nil
        _count = nil
        _firstPosition = nil
        _finalPosition = nil
      
        \(raw: genericParameters.map { "_rangeFor\($0) = nil" }.joined(separator: "\n") )
      }
      """
    ]
  }
  
  static func providePositionAfterPosition(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    let parameterCases = genericParameters.map { parameter in
      let p = parameter.lowercased()
      let P = parameter.lowercased()
      let pIndex = "\(p)Index"
      let nextPIndex = "next\(P)Index"
      
      return """
      case .\(p)(let \(pIndex)):
        guard let \(nextPIndex) = self.$\(p).subscriptableIndex(after: \(pIndex)) else {
          return firstPosition(after: .\(p))
        }
        return .\(p)(\(nextPIndex))
      """
    }
    
    return [
      """
      @usableFromInline
      internal func position(after position: Position) -> Position? {
        guard !isEmpty else {
        return nil
        }
        switch position {
        \(raw: parameterCases.joined(separator: "\n"))
        }
      }
      """
    ]
  }
  
  static func providePositionCalculationSupport(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    return [
      """
      @inlinable
      internal func position(
        _ position: Position,
        offsetBy distance: Int
      ) -> Position? {
        let linearPosition = self.linearPosition(forPosition: position)
        let destination = linearPosition + distance
        guard (0...self.count).contains(destination) else {
          preconditionFailure("Invalid navigation!")
        }
        guard destination < self.count else {
          return nil
        }
        return self.position(
          forLinearPosition: destination
        )
      }
      """,
      
      """
      @inlinable
      internal func distance(
        from start: Position,
        to end: Position
      ) -> Int {
        linearPosition(forPosition: end)
        -
        linearPosition(forPosition: start)
      }
      """
    ]
  }
  
  static func provideElementIndexAndPosition(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    return [
      """
      @usableFromInline
      internal typealias Element = A.Element
      """,
      """
      @usableFromInline
      internal typealias Index = Chain\(raw: genericParameters.count)CollectionIndex<
        \(raw: genericParameters.map { "\($0).Index" }.joined(separator: ",\n"))
      >
      """,
      
      """
      @usableFromInline
      internal typealias ArityPosition = Arity\(raw: genericParameters.count)Position
      """,
      
      """
      @usableFromInline
      internal typealias Position = Index.Position
      """,
      
      """
      @inlinable
      internal var startIndex: Index {
        guard let firstPosition = firstPosition else {
          return endIndex
        }
        return Index(position: firstPosition)
      }
      """,
      
      """
      @inlinable
      internal var endIndex: Index {
        Index.endIndex
      }
      """
    ]
  }
  
  static func providePositionSubscript(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    
    let parameterCases = genericParameters.map { parameter in
      let p = parameter.lowercased()
      let pIndex = "\(p)index"
      
      return """
      case .\(p)(let \(pIndex)):
        precondition(\(pIndex) < \(p).endIndex)
        return \(p)[\(pIndex)]
      """
    }
    
    return [
      """
      @inlinable
      internal subscript(position: Position) -> Element {
        switch position {
        \(raw: parameterCases.joined(separator: "\n"))
        }
      }
      """
    ]
  }

  static func provideFirstPositionAfter(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    return [
      """
      @inlinable
      internal func firstPosition(after position: ArityPosition) -> Position? {
        switch position {
        \(raw: genericParameters.map { parameter in "case .\(parameter.lowercased()): firstPositionAfter\(parameter)"}.joined(separator: "\n"))
        }
      }
      """
    ]
  }

  static func provideFinalPositionBefore(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    return [
      """
      @inlinable
      internal func finalPosition(before position: ArityPosition) -> Position? {
        switch position {
        \(raw: genericParameters.map { parameter in "case .\(parameter.lowercased()): finalPositionBefore\(parameter)"}.joined(separator: "\n"))
        }
      }
      """
    ]
  }

  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    var declarations: [DeclSyntax] = []
    declarations.append(
      contentsOf: try provideConstituentTupleAndAlgebraicProductRepresentation(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideFirstPositionAfter(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideFinalPositionBefore(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideExtremalPositions(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try providePositionLinearization(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideIsEmptyAndCount(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideResetCaches(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try providePositionAfterPosition(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try providePositionCalculationSupport(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideElementIndexAndPosition(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try providePositionSubscript(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    
    return declarations
  }
}

extension AddChainCollectionStorageImplementationMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard
      let classDeclaration = declaration.as(ClassDeclSyntax.self)
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }
    
    guard
      let genericParameters = classDeclaration.simpleGenericParameterNames,
      !genericParameters.isEmpty
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }

    print("HELLO")
    
    var declarations: [DeclSyntax] = []
    declarations.append(
      contentsOf: try provideRequiredInitializer(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideGenericCollectionStorage(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideFirstPositionAfterX(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideFinalPositionBeforeX(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideComponentRanges(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideWithDerivationMethods(
        of: node,
        providingMembersOf: declaration,
        conformingTo: protocols,
        in: context,
        genericParameters: genericParameters
      )
    )

    return declarations
  }
}


extension AddChainCollectionStorageImplementationMacro {

  static func provideGenericCollectionStorage(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    genericParameters.map { genericParameter in
      """
      @usableFromInline
      @GenericCollectionStorage
      internal var \(raw: genericParameter.lowercased()): \(raw: genericParameter) {
        didSet {
          resetCaches()
        }
      }
      """
    }
  }
  
  static func provideFirstPositionAfterX(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    genericParameters
      .enumerated()
      .map { (parameterIndex, parameter) in
        let functionArguments = genericParameters
          .enumerated()
          .map { (candidateIndex, candidateParameter) in
            switch candidateIndex <= parameterIndex {
            case true:
              "nil"
            case false:
              """
              $\(candidateParameter.lowercased()).firstSubscriptableIndex
              """
            }
          }.joined(separator: ",\n")
        
          return
            """
            @usableFromInline
            internal var firstPositionAfter\(raw: parameter): Position? {
              Position.firstNonNil(
                \(raw: functionArguments)
              )
            }
            """
      }
  }

  static func provideFinalPositionBeforeX(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    genericParameters
      .enumerated()
      .map { (parameterIndex, parameter) in
        let functionArguments = genericParameters
          .enumerated()
          .map { (candidateIndex, candidateParameter) in
            switch candidateIndex >= parameterIndex {
            case true:
              """
              $\(candidateParameter.lowercased()).finalSubscriptableIndex
              """
            case false:
              "nil"
            }
          }.joined(separator: ",\n")
        
        return
            """
            @usableFromInline
            internal var finalPositionBefore\(raw: parameter): Position? {
              Position.finalNonNil(
                \(raw: functionArguments)
              )
            }
            """
      }
  }
  
  // ResettableLazyCalculationMacro
  static func provideComponentRanges(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    genericParameters
      .enumerated()
      .map { (parameterIndex, parameter) in
        
        let methodBody: String
        switch parameterIndex == 0 {
        case true:
          methodBody =
          """
          guard !isEmpty else {
            return 0..<0
          }
          return 0..<$\(parameter.lowercased()).count
          """
        case false:
          methodBody =
          """
          guard !isEmpty else {
            return 0..<0
          }
          let previousUpperBound = rangeFor\(genericParameters[parameterIndex - 1]).upperBound
          let currentCount = $\(parameter.lowercased()).count
          return previousUpperBound..<(previousUpperBound + currentCount)
          """
        }
        
        return
          """
          @usableFromInline
          @ResettableLazyCalculation
          internal func calculateRangeFor\(raw: parameter)() -> Range<Int> {
            \(raw: methodBody)
          }
          """
      }
  }
  
  static func provideWithDerivationMethods(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    genericParameters
      .map { parameter in
        """
        @inlinable
        internal func with(\(raw: parameter.lowercased()): \(raw: parameter)) -> Self {
          withMutatedAlgebraicProductRepresentation {
            $0.\(raw: parameter.lowercased()) = \(raw: parameter.lowercased())
          }
        }

        """
      }
  }

  package static func provideRequiredInitializer(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    return [
      """
      @inlinable
      internal required init(
        \(raw: genericParameters.map { "_ \($0.lowercased()): \($0)" }.joined(separator: ", \n"))
      ) {
        \(raw: genericParameters.map { "self.\($0.lowercased()) = \($0.lowercased())" }.joined(separator: "\n"))
      }
      """
    ]
  }
  

}
