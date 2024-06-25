import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct ConditionallySendableMacro: SingleProtocolConditionalConformanceMacro, DatatypeAllOrNoneConditionalConformanceMacro {
  public static let associatedProtocol: String = "Sendable"
//  package static let protocolName: String = "Sendable"
//
//  public static func expansion(
//    of node: AttributeSyntax,
//    attachedTo declaration: some DeclGroupSyntax,
//    providingExtensionsOf type: some TypeSyntaxProtocol,
//    conformingTo protocols: [TypeSyntax],
//    in context: some MacroExpansionContext
//  ) throws -> [ExtensionDeclSyntax] {
//    // TODO: reintroduce some attachment-site validation
//    
//    guard
//      let (_, simpleGenericParameters) = declaration.typeNameWithAllSimpleGenericParameters(
//        excludingArchetypes: [.actor]
//      )
//    else {
//      // TODO: import previous error utilities
//      fatalError()
//    }
//    
//    let rawGenericParameterList: String = simpleGenericParameters
//      .lazy
//      .map { "\($0): \(protocolName)" }
//      .joined(separator: ", \n")
//    
//    return [
//      try ExtensionDeclSyntax(
//        """
//        extension \(type.trimmed) : \(raw: protocolName)
//        where
//        \(raw: rawGenericParameterList)
//        { }
//        """
//      )
//    ]
//  }
//
}

