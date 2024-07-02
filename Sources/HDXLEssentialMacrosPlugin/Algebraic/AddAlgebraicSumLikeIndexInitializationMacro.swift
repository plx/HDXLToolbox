import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddAlgebraicSumLikeIndexInitializationMacro: DiagnosticDomainAwareMacro { }

extension AddAlgebraicSumLikeIndexInitializationMacro: ContextualizedMemberMacro {
  
  public static let classAttachmentDisposition: AttachmentDisposition = .excluded
  public static let actorAttachmentDisposition: AttachmentDisposition = .excluded
  public static let protocolAttachmentDisposition: AttachmentDisposition = .excluded
  public static let enumAttachmentDisposition: AttachmentDisposition = .excluded

  // TODO: let classes adopt this (as convenience inits)
  public static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [DeclSyntax] {
    let genericParameters = try attachmentContext.expansionRequirement(
      property: \.simpleGenericParameterNames,
      of: attachmentContext.declaration
    )
    
    let (visibilityLevel, inlinabilityDisposition) = attachmentContext.functionOrMethodGenerationDetails
    let inlinabilityDispositionSyntax = inlinabilityDisposition?.sourceCodeStringRepresentation ?? ""
    
    return genericParameters.map { parameter in
      let p = parameter.lowercased()
      let P = parameter
      
      return """
      \(raw: inlinabilityDispositionSyntax)
      \(raw: visibilityLevel.keywordRepresentation) init(\(raw: p): \(raw: P)) {
        self.init(position: .\(raw: p)(\(raw: p)))
      }
      """
    }
    
  }
  
}
