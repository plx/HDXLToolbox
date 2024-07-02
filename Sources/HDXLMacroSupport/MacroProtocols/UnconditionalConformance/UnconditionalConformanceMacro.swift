import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors

public protocol UnconditionalConformanceMacro : ContextualizedExtensionMacro, DiagnosticDomainAwareMacro {
  static var conformedProtocolNames: [String] { get }
  
  static func conditionalConformanceDeclarations(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
    // TODO: add parameters if we hit one that needs extra logic?
  ) throws -> [DeclSyntax]
  
  static func unconditionalInheritanceClause(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> InheritanceClauseSyntax

  static func unconditionalExtensions(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [ExtensionDeclSyntax]
}

extension UnconditionalConformanceMacro {
  public static var protocolAttachmentDisposition: AttachmentDisposition { .excluded }
  
  public static func conditionalConformanceDeclarations(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
    // TODO: add parameters if we hit one that needs extra logic?
  ) throws -> [DeclSyntax] {
    []
  }

  public static func unconditionalInheritanceClause(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> InheritanceClauseSyntax {
    InheritanceClauseSyntax.forInheritedTypeNames(conformedProtocolNames)
  }

  public static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [ExtensionDeclSyntax] {
    try unconditionalExtensions(
      in: attachmentContext,
      providingExtensionsOf: type,
      conformingTo: protocols
    )
  }
}
