import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros

public protocol ContextualizedMemberMacro: MemberMacro, ContextualizedAttachedMacro, DiagnosticDomainAwareMacro {
  
  static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [DeclSyntax]
    
}

extension ContextualizedMemberMacro {
  
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
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
      conformingTo: protocols
    )
    
    return try autoformattedEquivalents(
      of: unformattedExpansion
    )
  }

}
