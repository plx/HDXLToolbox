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
      // TODO: import previous error utilities
      fatalError()
    }
    
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
        { }
        """
      )
    ]
  }
  
}

