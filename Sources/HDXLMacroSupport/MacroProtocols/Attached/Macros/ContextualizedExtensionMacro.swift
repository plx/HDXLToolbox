import SwiftSyntax
import SwiftBasicFormat
import SwiftDiagnostics
import SwiftSyntaxMacros

public protocol ContextualizedExtensionMacro: ExtensionMacro, ContextualizedAttachedMacro, DiagnosticDomainAwareMacro {
  
  static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [ExtensionDeclSyntax]
    
}

extension ContextualizedExtensionMacro {
  
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    let expansionContext = AttachedMacroContext(
      attributeNode: node,
      declaration: declaration,
      expansionContext: context,
      diagnosticDomainIdentifier: diagnosticDomainIdentifier
    )
    
    try validateDeclarationArchetype(
      for: expansionContext
    )
    
    let unformattedExpansion = try contextualizedExpansion(
      in: expansionContext,
      providingExtensionsOf: type,
      conformingTo: protocols
    )
    
    return try autoformattedEquivalents(
      of: unformattedExpansion
    )
  }

}
