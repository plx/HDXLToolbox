import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct ConditionallyAutoIdentifiableMacro: AllOrNoneConditionalConformanceMacro {
  public static let requiredProtocolNames: [String] = ["Hashable"]
  public static let conformedProtocolNames: [String] = ["Identifiable", "AutoIdentifiable"]

  public static func conditionalConformanceDeclarations(
    in attachmentContext: some ExtensionMacroContextProtocol,
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> [DeclSyntax] {
    // we have to auto-synthesize the components *if* we're package-or-internal
    // and also `@usableFromInline`?
    guard
      parameters.visibilityLevel == .package || parameters.visibilityLevel == .internal,
      let typeLevelInlinabilityDisposition = parameters.typeInlinabilityDisposition,
      typeLevelInlinabilityDisposition == .usableFromInline
    else {
      return []
    }
    
    let typealiasInlinabilityDisposition = InlinabilityDisposition.strongestAvailableTypeDeclarationInlinability(
      visibilityLevel: parameters.visibilityLevel,
      inlinabilityDisposition: parameters.typeInlinabilityDisposition
    )
    
    let typealiasInlinabilitySyntax = typealiasInlinabilityDisposition?.sourceCodeStringRepresentation ?? ""
    
    let methodInlinabilityDisposition = InlinabilityDisposition.strongestAvailableFunctionOrMethodInlinability(
      visibilityLevel: parameters.visibilityLevel,
      inlinabilityDisposition: parameters.typeInlinabilityDisposition
    )
    
    let methodInlinabilitySyntax = methodInlinabilityDisposition?.sourceCodeStringRepresentation ?? ""
    
    return [
      """
      \(raw: typealiasInlinabilitySyntax)
      \(raw: parameters.visibilityLevel.keywordRepresentation) typealias ID = Self
      """,

      """
      \(raw: methodInlinabilitySyntax)
      \(raw: parameters.visibilityLevel.keywordRepresentation) var id: ID { self }
      """
    ]
  }

}

