import SwiftSyntax
import SwiftSyntaxMacros
import HDXLMacroSupport

public struct COWBoxPropertyMacro: DiagnosticDomainAwareMacro {}

extension COWBoxPropertyMacro: ContextualizedAccessorMacro {
  
  public static let protocolAttachmentDisposition: AttachmentDisposition = .excluded
  public static let enumAttachmentDisposition: AttachmentDisposition = .excluded
  
  public static func contextualizedExpansion(
    in attachmentContext: some AccessorMacroContextProtocol
  ) throws -> [AccessorDeclSyntax] {
    
    let variableDeclaration = try attachmentContext.requireDeclaration(
      as: VariableDeclSyntax.self
    )
    
    let variableIdentifierPattern = try attachmentContext.requireSyntaxProperty(
      \.bindings.first?.pattern,
      of: variableDeclaration,
      as: IdentifierPatternSyntax.self
    )
    
    return [
      """
      get {
        storage.value.\(variableIdentifierPattern.identifier)
      }
      """,
      """
      set {
        ensureUniqueStorage()
        storage.value.\(variableIdentifierPattern.identifier) = newValue
      }
      """
    ]
  }
}

