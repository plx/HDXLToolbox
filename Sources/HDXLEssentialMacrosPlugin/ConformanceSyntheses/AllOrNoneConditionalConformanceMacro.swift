import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

internal protocol AllOrNoneConditionalConformanceMacro: ExtensionMacro {
  
  static var requiredProtocolNames: [String] { get }
  static var conformedProtocolNames: [String] { get }
  static var excludedTypeArchetypes: Set<TypeDeclarationArchetype> { get }
 
  static func extensionDeclarations(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameterNames: some Collection<String>,
    visibilityLevel: VisibilityLevel,
    typeInlinabilityDisposition: InlinabilityDisposition?,
    methodInlinabilityDisposition: InlinabilityDisposition?
  ) throws -> [ExtensionDeclSyntax]
}


extension AllOrNoneConditionalConformanceMacro {
  static func conditionalConformanceClause(
    for type: some TypeSyntaxProtocol
  ) throws -> String {
    """
    extension \(type.trimmedDescription) : \(conformedProtocolNames.joined(separator: ", "))
    """
  }
  
  static func conditionalConformanceConditions(genericParameterNames: some Collection<String>) throws -> String {
    guard !genericParameterNames.isEmpty else {
      throw TempError.noGenericsFound
    }
           
    let requiredProtocolNames = requiredProtocolNames
    guard !requiredProtocolNames.isEmpty else {
      throw TempError.noConformancesProvided
    }
    
    return requiredProtocolNames
      .localOnDemandMap { requiredProtocolName in
        genericParameterNames
          .onDemandMap { genericParameterName in
            "\(genericParameterName): \(requiredProtocolName)"
          }
      }
      .joined()
      .joined(separator: ", \n")
  }
}

internal protocol SingleProtocolConditionalConformanceMacro: AllOrNoneConditionalConformanceMacro {
  
  static var associatedProtocol: String { get }
}

extension SingleProtocolConditionalConformanceMacro {
  
  static var requiredProtocolNames: [String] { [associatedProtocol] }
  static var conformedProtocolNames: [String] { [associatedProtocol] }
}

protocol DatatypeAllOrNoneConditionalConformanceMacro: AllOrNoneConditionalConformanceMacro { }

extension DatatypeAllOrNoneConditionalConformanceMacro {
  
  static var excludedTypeArchetypes: Set<TypeDeclarationArchetype> { [.actor] }
  
}

extension AllOrNoneConditionalConformanceMacro {
  
  static func extensionDeclarations(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext,
    genericParameterNames: some Collection<String>,
    visibilityLevel: VisibilityLevel,
    typeInlinabilityDisposition: InlinabilityDisposition?,
    methodInlinabilityDisposition: InlinabilityDisposition?
  ) throws -> [ExtensionDeclSyntax] {
    return [
      try ExtensionDeclSyntax(
        """
        \(raw: conditionalConformanceClause(for: type))
        where
        \(raw: conditionalConformanceConditions(genericParameterNames: genericParameterNames))
        { }
        """
      )
    ]
  }

}

extension AllOrNoneConditionalConformanceMacro {
  
  
  
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
        excludingArchetypes: excludedTypeArchetypes
      )
    else {
      throw TempError.noGenericsFound
    }
    
    let visibilityLevel = declaration.visibilityLevel ?? .internal
    
    let typeInlinabilityDisposition = InlinabilityDisposition.strongestAvailableTypeDeclarationInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: declaration.inlinabilityDisposition
    )
    
    let methodInlinabilityDisposition = InlinabilityDisposition.strongestAvailableFunctionOrMethodInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: declaration.inlinabilityDisposition
    )
    
    return try extensionDeclarations(
      of: node,
      attachedTo: declaration,
      providingExtensionsOf: type,
      conformingTo: protocols,
      in: context,
      genericParameterNames: simpleGenericParameters,
      visibilityLevel: visibilityLevel,
      typeInlinabilityDisposition: typeInlinabilityDisposition,
      methodInlinabilityDisposition: methodInlinabilityDisposition
    )

  }

}
