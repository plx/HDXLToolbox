import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct COWBoxPropertyMacro: AccessorMacro {
  
  public static func expansion(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AccessorDeclSyntax] {
    guard
      let variableDeclaration = declaration.as(VariableDeclSyntax.self),
      let variableBinding = variableDeclaration.bindings.first,
      let variableIdentifierPattern = variableBinding.pattern.as(IdentifierPatternSyntax.self)
    else {
      fatalError() // TODO: real errors
    }
    
    return [
      """
      get {
        storage.value.\(variableIdentifierPattern.identifier)
      }
      """,
      """
      set {
        ensureUniqueStorage()
        storage.value.\(variableIdentifierPattern.identifier) = newValue
      }
      """
    ]
  }
}

