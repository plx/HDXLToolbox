import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddAlgebraicSumLikeIndexInitializationMacro { }

extension AddAlgebraicSumLikeIndexInitializationMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard
      let genericParameters = declaration.simpleGenericParameterNames,
      let visibilityLevel = declaration.visibilityLevel
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }
    
    let inlinabilityDisposition = InlinabilityDisposition.strongestAvailableFunctionOrMethodInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: declaration.inlinabilityDisposition
    )
    
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
