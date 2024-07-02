import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

// MARK: AddChainCollectionStorageVariableComponentsMacro

public struct AddChainCollectionStorageVariableComponentsMacro : DiagnosticDomainAwareMacro { }

// MARK: - ContextualizedTypeAttachedMacro

extension AddChainCollectionStorageVariableComponentsMacro : ContextualizedTypeAttachedMacro {
  public static let classAttachmentDisposition: AttachmentDisposition = .required
}

// MARK: - ContextualizedExtensionMacro

extension AddChainCollectionStorageVariableComponentsMacro: ContextualizedExtensionMacro {
    
  public static func contextualizedExpansion(
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> [ExtensionDeclSyntax] {
    let genericParameters = try attachmentContext.requireNonEmptyProperty(
      \.simpleGenericParameterNames,
       of: attachmentContext.declaration
    )
    
    return [
      try provideMinMaxExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideContainsExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideEquatableExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideHashableExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideEncodableExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideDecodableExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideBidirectionalNavigationExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideCloneableObjectExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    ]
  }
  
}

extension AddChainCollectionStorageVariableComponentsMacro: ContextualizedMemberMacro {
  
  public static func contextualizedExpansion(
    in attachmentContext: some MemberMacroContextProtocol
  ) throws -> [DeclSyntax] {
    let classDeclaration = try attachmentContext.requireDeclaration(
      as: ClassDeclSyntax.self
    )
    
    let genericParameters = try attachmentContext.requireNonEmptyProperty(
      \.simpleGenericParameterNames,
       of: classDeclaration
    )
    
    var declarations: [DeclSyntax] = []
    declarations.append(
      contentsOf: try provideRequiredInitializer(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideGenericCollectionStorage(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideFirstPositionAfterX(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideFinalPositionBeforeX(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideComponentRanges(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideWithDerivationMethods(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    
    return declarations
  }
}


// MARK: - Details

extension AddChainCollectionStorageVariableComponentsMacro {
  
  package static func provideMinMaxExtension(
    in attachmentContext: some ExtensionMacroContextProtocol,
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
    in attachmentContext: some ExtensionMacroContextProtocol,
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
    in attachmentContext: some ExtensionMacroContextProtocol,
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
    in attachmentContext: some ExtensionMacroContextProtocol,
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
    in attachmentContext: some ExtensionMacroContextProtocol,
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
    in attachmentContext: some ExtensionMacroContextProtocol,
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
    in attachmentContext: some ExtensionMacroContextProtocol,
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
    in attachmentContext: some ExtensionMacroContextProtocol,
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
    in attachmentContext: some ExtensionMacroContextProtocol,
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
}

extension AddChainCollectionStorageVariableComponentsMacro {

  static func provideGenericCollectionStorage(
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
  
  static func provideComponentRanges(
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
