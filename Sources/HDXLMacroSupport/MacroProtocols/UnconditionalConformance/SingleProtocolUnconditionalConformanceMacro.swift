import SwiftSyntax
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

public protocol SingleProtocolUnconditionalConformanceMacro: UnconditionalConformanceMacro, ContextualizedExtensionMacro, DiagnosticDomainAwareMacro {
  
  static var associatedProtocol: String { get }

  static func unconditionalExtension(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> ExtensionDeclSyntax

}

extension SingleProtocolUnconditionalConformanceMacro {
  
  public static var protocolAttachmentDisposition: AttachmentDisposition { .excluded }
  
  public static var conformedProtocolNames: [String] { [associatedProtocol]  }
 
  public static func unconditionalExtension(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> ExtensionDeclSyntax {
    ExtensionDeclSyntax(
      extendedType: type,
      inheritanceClause: try unconditionalInheritanceClause(
        in: attachmentContext,
        providingExtensionsOf: type,
        conformingTo: protocols
      ),
      memberBlock: MemberBlockSyntax(
        declarations: try conditionalConformanceDeclarations(
          in: attachmentContext,
          providingExtensionsOf: type,
          conformingTo: protocols
        )
      )
    )
  }
  
  public static func unconditionalExtensions(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [ExtensionDeclSyntax] {
    [
      try unconditionalExtension(
        in: attachmentContext,
        providingExtensionsOf: type,
        conformingTo: protocols
      )
    ]
  }

}
