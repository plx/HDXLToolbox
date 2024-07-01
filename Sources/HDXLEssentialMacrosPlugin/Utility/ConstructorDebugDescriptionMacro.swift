import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct ConstructorDebugDescriptionMacro : DiagnosticDomainAwareMacro {}

extension ConstructorDebugDescriptionMacro: ContextualizedExtensionMacro {
  
  public static let enumAttachmentDisposition: AttachmentDisposition = .excluded
  
  public static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [ExtensionDeclSyntax] {
    let memberwiseInitializer = try attachmentContext.expansionRequirement(
      "We need to find an `init` that's been explicitly-annotated with `PreferredMemberwiseInitializer`"
    ) {
      attachmentContext
        .declaration
        .memberBlock
        .members
        .compactMap({ $0.decl.as(InitializerDeclSyntax.self) })
        .first(where: \.isPreferredMemberwiseInitializer)
    }

    let visibilityLevel = try attachmentContext.expansionRequirement(
      property: \.visibilityLevel,
      of: attachmentContext.declaration
    )
    
    let inlinabilityDisposition = InlinabilityDisposition.strongestAvailableFunctionOrMethodInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: attachmentContext.declaration.inlinabilityDisposition
    )
    
    let inlinabilityText: String = inlinabilityDisposition?.sourceCodeStringRepresentation ?? ""
    
    // TODO: create a convenience-constructor for the constructor-of part of this method
    let constructorArgumentsClause = memberwiseInitializer
      .signature
      .parameterClause
      .parameters
      .map { parameter in
        (parameter.secondName ?? parameter.firstName).trimmed.text
      }
      .map { (parameterName) in
        String(repeating: " ", count: 8) + "(\"\(parameterName)\", \(parameterName))"
      }
      .joined(separator: ",\n")
    
    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : CustomDebugStringConvertible {
        
          \(raw: inlinabilityText)
          \(visibilityLevel.tokenRepresentation()) var debugDescription: String {
            String(
              forConstructorOf: Self.self,
              arguments: (
                \(raw: constructorArgumentsClause)
              )
            )
          }
        
        }
        """
      )
    ]
  }
  
}

