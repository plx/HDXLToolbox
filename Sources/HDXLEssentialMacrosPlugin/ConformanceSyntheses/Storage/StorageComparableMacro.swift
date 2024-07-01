import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct StorageComparableMacro: DiagnosticDomainAwareMacro { }

extension StorageComparableMacro: ContextualizedExtensionMacro {
  public static let actorAttachmentDisposition: AttachmentDisposition = .excluded
  public static let protocolAttachmentDisposition: AttachmentDisposition = .excluded
  public static let enumAttachmentDisposition: AttachmentDisposition = .excluded
  
  public static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [ExtensionDeclSyntax] {
    let visibilityLevel = attachmentContext.visibilityLevel
    
    let operatorInlinabilityDisposition = InlinabilityDisposition.strongestAvailableFunctionOrMethodInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: attachmentContext.declaration.inlinabilityDisposition
    )
    
    let operatorInlinabilityText: String = operatorInlinabilityDisposition?.sourceCodeStringRepresentation ?? ""

    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : Comparable {
        
          \(raw: operatorInlinabilityText)
          \(visibilityLevel.tokenRepresentation()) static func < (
            lhs: Self,
            rhs: Self
          ) -> Bool {
            lhs.storage == rhs.storage
          }
        
        }
        """
      )
    ]
  }

}

