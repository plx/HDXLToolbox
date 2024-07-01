import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros

public protocol ContextualizedMemberAttributeMacro: MemberAttributeMacro, ContextualizedAttachedMacro, DiagnosticDomainAwareMacro {
  
  static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingAttributesFor member: some DeclSyntaxProtocol
  ) throws -> [AttributeSyntax]
    
}

extension ContextualizedMemberAttributeMacro {
  
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingAttributesFor member: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AttributeSyntax] {
    let expansionContext = AttachedMacroContext(
      attributeNode: node,
      declaration: declaration,
      expansionContext: context,
      diagnosticDomainIdentifier: diagnosticDomainIdentifier
    )
    
    try validateDeclarationArchetype(
      for: expansionContext
    )
    
    return try autoformattedEquivalents(
      of: contextualizedExpansion(
        in: expansionContext,
        providingAttributesFor: member
      )
    )
  }

}
