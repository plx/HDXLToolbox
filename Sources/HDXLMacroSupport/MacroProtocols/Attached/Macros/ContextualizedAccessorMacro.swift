import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros

public protocol ContextualizedAccessorMacro: AccessorMacro, ContextualizedAttachedMacro, DiagnosticDomainAwareMacro {
  
  static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclSyntaxProtocol, some MacroExpansionContext>
  ) throws -> [AccessorDeclSyntax]
  
}

extension ContextualizedAccessorMacro {
  
  public static func expansion(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AccessorDeclSyntax] {
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
