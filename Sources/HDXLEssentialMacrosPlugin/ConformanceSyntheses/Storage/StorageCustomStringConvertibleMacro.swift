import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct StorageCustomStringConvertibleMacro: DiagnosticDomainAwareMacro { }

extension StorageCustomStringConvertibleMacro: ContextualizedExtensionMacro {
  
  public static let actorAttachmentDisposition: AttachmentDisposition = .excluded
  public static let protocolAttachmentDisposition: AttachmentDisposition = .excluded
  public static let enumAttachmentDisposition: AttachmentDisposition = .excluded

  public static func contextualizedExpansion(
    in attachmentContext: some ExtensionMacroContextProtocol
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
        extension \(attachmentContext.extendedType.trimmed) : CustomStringConvertible {
        
          \(raw: operatorInlinabilityText)
          \(visibilityLevel.tokenRepresentation()) var description: String {
            String(describing: storage)
          }
        
        }
        """
      )
    ]
  }

}

