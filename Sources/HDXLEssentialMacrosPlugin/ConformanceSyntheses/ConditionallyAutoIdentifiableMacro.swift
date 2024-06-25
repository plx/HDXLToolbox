import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct ConditionallyAutoIdentifiableMacro: ExtensionMacro {
  package static let requiredProtocolName: String = "Hashable"
  package static let conformedProtocolNames: [String] = ["Identifiable", "AutoIdentifiable"]
  
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    // TODO: reintroduce some attachment-site validation
    
    guard
      let (_, simpleGenericParameters) = declaration.typeNameWithAllSimpleGenericParameters(
        excludingArchetypes: [.actor]
      )
    else {
      throw TempError.noGenericsFound
    }
    
    let visibilityLevel = declaration.visibilityLevel ?? .internal

    let typeInlinabilityDisposition = InlinabilityDisposition.strongestAvailableTypeDeclarationInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: declaration.inlinabilityDisposition
    )

    let typeInlinabilityText: String = typeInlinabilityDisposition?.sourceCodeStringRepresentation ?? ""

    let methodInlinabilityDisposition = InlinabilityDisposition.strongestAvailableFunctionOrMethodInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: declaration.inlinabilityDisposition
    )

    let methodInlinabilityText: String = methodInlinabilityDisposition?.sourceCodeStringRepresentation ?? ""
    
    let rawGenericParameterList: String = simpleGenericParameters
      .lazy
      .map { "\($0): \(requiredProtocolName)" }
      .joined(separator: ", \n")
    
    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : \(raw: conformedProtocolNames.joined(separator: ", "))
        where
        \(raw: rawGenericParameterList)
        { 
          \(raw: typeInlinabilityText)
          \(visibilityLevel.tokenRepresentation()) typealias ID = Self
        
          \(raw: methodInlinabilityText)
          \(visibilityLevel.tokenRepresentation()) var id: ID { self }
        }
        """
      )
    ]
  }
  
}

