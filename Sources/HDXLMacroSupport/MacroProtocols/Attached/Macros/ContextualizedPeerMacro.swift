import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros

public protocol ContextualizedPeerMacro: PeerMacro, ContextualizedAttachedMacro, DiagnosticDomainAwareMacro {
  
  static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclSyntaxProtocol, some MacroExpansionContext>
  ) throws -> [DeclSyntax]
  
}

extension ContextualizedPeerMacro {
  
  public static func expansion(
    of node: AttributeSyntax,
    providingPeersOf declaration: some DeclSyntaxProtocol,
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
      in: expansionContext
    )

    return try autoformattedEquivalents(
      of: unformattedExpansion
    )
  }
  
}
