import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddAlgebraicProductLikeStorageAndForwardingMacro : DiagnosticDomainAwareMacro { }

extension AddAlgebraicProductLikeStorageAndForwardingMacro: ContextualizedMemberMacro {
  
  public static let structAttachmentDisposition: AttachmentDisposition = .required
  
  public static func contextualizedExpansion(
    in attachmentContext: some MemberMacroContextProtocol
  ) throws -> [DeclSyntax] {
    
    let structDeclaration = try attachmentContext.requireDeclaration(
      as: StructDeclSyntax.self
    )
    let genericParameters = try attachmentContext.requireNonEmptyProperty(
      \.simpleGenericParameterNames,
       of: structDeclaration
    )
    
    let genericParameterSuffix = "<\(genericParameters.joined(separator: ","))>"
    
    let typeName = structDeclaration.name.text
    let storageTypeName = "\(typeName)Storage\(genericParameterSuffix)"
    
    return [
      """
      @usableFromInline
      internal typealias Storage = \(raw: storageTypeName)
      """,
      
      """
      @usableFromInline
      internal var storage: Storage
      """,
      
      """
      @inlinable
      internal init(storage: Storage) {
        self.storage = storage
      }
      """,
      
      """
      @inlinable
      @PreferredMemberwiseInitializer
      public init(
        \(raw: genericParameters.map { "_ \($0.lowercased()): \($0)" }.joined(separator: ",\n"))
      ) {
        self.init(
          storage: Storage(
            \(raw: genericParameters.map { "\($0.lowercased())" }.joined(separator: ",\n"))
          )
        )
      }
      """
    ] + genericParameters.map { genericParameter in
      """
      @inlinable
      @COWProperty
      public var \(raw: genericParameter.lowercased()): \(raw: genericParameter)
      """
    }
  }
}
