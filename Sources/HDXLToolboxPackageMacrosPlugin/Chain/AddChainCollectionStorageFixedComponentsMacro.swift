import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport


// MARK: AddChainCollectionStorageFixedComponentsMacro

public struct AddChainCollectionStorageFixedComponentsMacro: DiagnosticDomainAwareMacro { }

// MARK: - ContextualizedTypeAttachedMacro

extension AddChainCollectionStorageFixedComponentsMacro : ContextualizedTypeAttachedMacro {
  public static let classAttachmentDisposition: AttachmentDisposition = .required
}

// MARK: - ContextualizedMemberMacro

extension AddChainCollectionStorageFixedComponentsMacro: ContextualizedMemberMacro {
  
  public static func contextualizedExpansion(
    in attachmentContext: some MemberMacroContextProtocol
  ) throws -> [DeclSyntax] {
    let genericParameters = try attachmentContext.requireNonEmptyProperty(
      \.simpleGenericParameterNames,
       of: attachmentContext.declaration
    )
    
    var declarations: [DeclSyntax] = []
    declarations.append(
      contentsOf: try provideConstituentTupleAndAlgebraicProductRepresentation(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideFirstPositionAfter(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideFinalPositionBefore(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideExtremalPositions(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try providePositionLinearization(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideIsEmptyAndCount(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideResetCaches(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try providePositionAfterPosition(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try providePositionCalculationSupport(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try provideElementIndexAndPosition(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    declarations.append(
      contentsOf: try providePositionSubscript(
        in: attachmentContext,
        genericParameters: genericParameters
      )
    )
    
    return declarations
  }
}

// MARK: Extension-Macro Details

// MARK: Member-Macro Details

extension AddChainCollectionStorageFixedComponentsMacro {
  
  static func provideConstituentTupleAndAlgebraicProductRepresentation(
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
    in attachmentContext: some MemberMacroContextProtocol,
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
  
}
