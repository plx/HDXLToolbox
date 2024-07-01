import SwiftSyntax
import SwiftSyntaxMacros
import HDXLMacroSupport

public struct COWPropertyMacro: DiagnosticDomainAwareMacro { }

extension COWPropertyMacro: ContextualizedAccessorMacro {
  
  public static let protocolAttachmentDisposition: AttachmentDisposition = .excluded
  public static let enumAttachmentDisposition: AttachmentDisposition = .excluded
  
  public static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclSyntaxProtocol, some MacroExpansionContext>
  ) throws -> [AccessorDeclSyntax] {
    let variableDeclaration = try attachmentContext.expansionRequirement(
      declarationAs: VariableDeclSyntax.self
    )
    
    let variableIdentifierPattern = try attachmentContext.expansionRequirement(
      property: \.bindings.first,
      of: variableDeclaration,
      as: IdentifierPatternSyntax.self
    )

    return [
      """
      get {
        storage.\(variableIdentifierPattern.identifier)
      }
      """,
      """
      set {
        ensureUniqueStorage()
        storage.\(variableIdentifierPattern.identifier) = newValue
      }
      """
    ]
  }
}

