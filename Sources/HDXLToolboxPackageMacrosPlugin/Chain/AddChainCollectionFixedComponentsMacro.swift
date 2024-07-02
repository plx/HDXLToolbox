import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddChainCollectionFixedComponentsMacro : DiagnosticDomainAwareMacro { }

extension AddChainCollectionFixedComponentsMacro: ContextualizedTypeAttachedMacro {
  public static let structAttachmentDisposition: AttachmentDisposition = .required
}

extension AddChainCollectionFixedComponentsMacro: ContextualizedMemberMacro {
  
  public static func contextualizedExpansion(
    in attachmentContext: some MemberMacroContextProtocol
  ) throws -> [DeclSyntax] {
    return []
  }
}

extension AddChainCollectionFixedComponentsMacro: ContextualizedExtensionMacro {

  public static func contextualizedExpansion(
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> [ExtensionDeclSyntax] {
    
    let genericParameters = try attachmentContext.requireNonEmptyProperty(
      \.simpleGenericParameterNames,
       of: attachmentContext.declaration
    )
    
    return [
      try provideContainsExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideMinMaxExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideCollectionExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      ),
      try provideBidirectionalCollectionExtension(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    ]
  }
}

// MARK: Extension-Macro Details


extension AddChainCollectionFixedComponentsMacro {
  
  package static func provideMinMaxExtension(
    in attachmentContext: some ExtensionMacroContextProtocol,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    try ExtensionDeclSyntax(
      """
      extension Chain\(raw: genericParameters.count)Collection where Element: Comparable {
      
        @inlinable
        public func min() -> Element? { 
          storage.min()
        }
        
        @inlinable
        public func max() -> Element? { 
          storage.max() 
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
      extension Chain\(raw: genericParameters.count)Collection where Element: Equatable {
      
        @inlinable
        public func contains(_ element: Element) -> Bool { 
          storage.contains(element)
        }

      }
      """
    )
  }

  package static func provideCollectionExtension(
    in attachmentContext: some ExtensionMacroContextProtocol,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    ExtensionDeclSyntax(
      extendedType: attachmentContext.extendedType,
      inheritanceClause: InheritanceClauseSyntax(
        inheritedTypes: InheritedTypeListSyntax([
          InheritedTypeSyntax(type: IdentifierTypeSyntax(name: .identifier("Collection")))
        ])
      ),
      genericWhereClause: GenericWhereClauseSyntax(
        requirements: genericParameters.map { genericParameter in
          .requirement(
            that: genericParameter,
            inheritsFrom: "Collection"
          )
        }
      ),
      memberBlock: MemberBlockSyntax(
        declarations: try provideCollectionExtensionDeclarations(
          in: attachmentContext,
          genericParameters: genericParameters
        )
      )
    )
  }

  package static func provideBidirectionalCollectionExtension(
    in attachmentContext: some ExtensionMacroContextProtocol,
    genericParameters: [String]
  ) throws -> ExtensionDeclSyntax {
    ExtensionDeclSyntax(
      extendedType: attachmentContext.extendedType,
      inheritanceClause: InheritanceClauseSyntax(
        inheritedTypes: InheritedTypeListSyntax([
          InheritedTypeSyntax(type: IdentifierTypeSyntax(name: .identifier("BidirectionalCollection")))
        ])
      ),
      genericWhereClause: GenericWhereClauseSyntax(
        requirements: genericParameters.map { genericParameter in
            .requirement(
              that: genericParameter,
              inheritsFrom: "BidirectionalCollection"
            )
        }
      ),
      memberBlock: MemberBlockSyntax(
        declarations: [
          DeclSyntax(
            """
            @inlinable
            public func index(before index: Index) -> Index {
              precondition(index > startIndex)
              switch index.storage {
              case .position(let position):
                guard let previousPosition = storage.position(before: position) else {
                  preconditionFailure("Tried to go back from the start index in \\(String(reflecting: self))!")
                }
                return Index(position: previousPosition)
              case .endIndex:
                guard let finalPosition = storage.finalPosition else {
                  preconditionFailure("Tried to go back from the start index in \\(String(reflecting: self))!")
                }
                return Index(position: finalPosition)
              }
            }
            """
          )
        ]
      )
    )
  }

  package static func provideCollectionExtensionDeclarations(
    in attachmentContext: some ExtensionMacroContextProtocol,
    genericParameters: [String]
  ) throws -> [DeclSyntax] {
    
    let arity = genericParameters.count
    return [
      """
      public typealias Element = A.Element
      """,

      """
      public typealias Index = Chain\(raw: arity)CollectionIndex<
        \(raw: genericParameters.map { "\($0).Index" }.joined(separator: ",\n"))
      >
      """,
      
      """
      @inlinable
      public var isEmpty: Bool {
        storage.isEmpty
      }
      """,
      
      """
      @inlinable
      public var startIndex: Index {
        storage.startIndex
      }
      """,

      """
      @inlinable
      public var endIndex: Index {
        storage.endIndex
      }
      """,

      """
      @inlinable
      public subscript(index: Index) -> Element {
        switch index.storage {
        case .position(let position):
          return storage[position]
        case .endIndex:
          preconditionFailure("Tried to subscript the end index on \\(String(reflecting: self))!")
        }
      }
      """,
      
      """
      @inlinable
      internal func linearIndex(forIndex index: Index) -> Int {
        switch index.storage {
        case .position(let position):
          storage.linearPosition(forPosition: position)
        case .endIndex:
          count
        }
      }
      """,
      
      """
      @inlinable
      internal func index(forLinearIndex linearIndex: Int) -> Index {
        guard (0...count).contains(linearIndex) else {
          preconditionFailure("Attempted to convert invalid linearIndex \\(linearIndex) to index in \\(String(reflecting: self))!")
        }
        guard linearIndex < count else {
          return endIndex
        }
        return Index(
          position: storage.position(
            forLinearPosition: linearIndex
          )
        )
      }
      """,

      """
      @inlinable
      public func distance(
        from start: Index,
        to end: Index
      ) -> Int {
        linearIndex(forIndex: end)
        -
        linearIndex(forIndex: start)
      }
      """,
      
      """
      @inlinable
      public func index(after index: Index) -> Index {
        switch index.storage {
        case .position(let position):
          guard let nextPosition = storage.position(after: position) else {
            return endIndex
          }
          return Index(position: nextPosition)
        case .endIndex:
          preconditionFailure("Tried to advance the end index on \\(String(reflecting: self))!")
        }
      }
      """,
      
      """
      @inlinable
      public func index(
        _ i: Index,
        offsetBy distance: Int
      ) -> Index {
        guard distance != 0 else {
          return i
        }
        return index(
          forLinearIndex: (
            linearIndex(forIndex: i)
            +
            distance
          )
        )
      }
      """,
      
      """
      @inlinable
      public func index(
        _ i: Index,
        offsetBy distance: Int,
        limitedBy limit: Index
      ) -> Index? {
        let destination = linearIndex(forIndex: i) + distance
        let boundary = linearIndex(forIndex: limit)
        if distance < 0 {
          guard boundary <= destination else {
            return nil
          }
          return index(forLinearIndex: destination)
        } else if distance > 0 {
          guard destination <= boundary else {
            return nil
          }
          return index(forLinearIndex: destination)
        } else {
          return i
        }
      }
      """
    ]
  }
}
