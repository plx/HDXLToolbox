import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

protocol UnconditionalConformanceMacro : ExtensionMacro {
  static var conformedProtocolNames: [String] { get }
    
  static func preflightExpansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws
    
}

extension UnconditionalConformanceMacro {
  
  static func preflightExpansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws {
    
  }

  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    // TODO: reintroduce some attachment-site validation
    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : \(raw: conformedProtocolNames.joined(separator: ", ")) { }
        """
      )
    ]
  }
}

protocol SingleProtocolUnconditionalConformanceMacro: UnconditionalConformanceMacro {
  
  static var associatedProtocol: String { get }
}

extension SingleProtocolUnconditionalConformanceMacro {
  
  public static var conformedProtocolNames: [String] { [associatedProtocol] }
}

public struct AlwaysSendableMacro: SingleProtocolUnconditionalConformanceMacro {
  static let associatedProtocol: String = "Sendable"
}

public struct AlwaysEquatableMacro: SingleProtocolUnconditionalConformanceMacro {
  static let associatedProtocol: String = "Equatable"
}

public struct AlwaysComparableMacro: SingleProtocolUnconditionalConformanceMacro {
  static let associatedProtocol: String = "Comparable"
}

public struct AlwaysHashableMacro: SingleProtocolUnconditionalConformanceMacro {
  static let associatedProtocol: String = "Hashable"
}

public struct AlwaysEncodableMacro: SingleProtocolUnconditionalConformanceMacro {
  static let associatedProtocol: String = "Encodable"
}

public struct AlwaysDecodableMacro: SingleProtocolUnconditionalConformanceMacro {
  static let associatedProtocol: String = "Decodable"
}

public struct AlwaysCodableMacro: SingleProtocolUnconditionalConformanceMacro {
  static let associatedProtocol: String = "Codable"
}

public struct AlwaysCaseIterableMacro: SingleProtocolUnconditionalConformanceMacro {
  static let associatedProtocol: String = "CaseIterable"
}
