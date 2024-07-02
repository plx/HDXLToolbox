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
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> [DeclSyntax]
  
  static func unconditionalInheritanceClause(
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> InheritanceClauseSyntax

  static func unconditionalExtensions(
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> [ExtensionDeclSyntax]
}

extension UnconditionalConformanceMacro {
  public static var protocolAttachmentDisposition: AttachmentDisposition { .excluded }
  
  public static func conditionalConformanceDeclarations(
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> [DeclSyntax] {
    []
  }

  public static func unconditionalInheritanceClause(
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> InheritanceClauseSyntax {
    InheritanceClauseSyntax.forInheritedTypeNames(conformedProtocolNames)
  }

  public static func contextualizedExpansion(
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> [ExtensionDeclSyntax] {
    try unconditionalExtensions(
      in: attachmentContext
    )
  }
}
