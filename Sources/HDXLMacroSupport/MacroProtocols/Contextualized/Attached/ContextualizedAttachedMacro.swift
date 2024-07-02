import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

public protocol ContextualizedAttachedMacro: AttachedMacro, DiagnosticDomainAwareMacro {
  
  static func validateDeclarationArchetype(
    for attachmentContext: some AttachedMacroContextProtocol
  ) throws

  static func validateMacroInvocationNode(
    _ attributeSyntax: AttributeSyntax
  ) throws
  
}

extension ContextualizedAttachedMacro {

  @inlinable
  public static func validateDeclarationArchetype(
    for attachmentContext: some AttachedMacroContextProtocol
  ) throws {
    return // default: allow everything
  }

  @inlinable
  public static func validateMacroInvocationNode(
    _ attributeSyntax: AttributeSyntax
  ) throws {
    return // default: allow everything
  }

}
