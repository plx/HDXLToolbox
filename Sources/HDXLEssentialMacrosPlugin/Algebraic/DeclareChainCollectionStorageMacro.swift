import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport


public struct DeclareChainCollectionStorageMacro: DeclarationMacro {
  
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard
      let arityArgument = node.arguments.first,
      arityArgument.label?.text == "arity",
      let arityExpression = arityArgument.expression.as(IntegerLiteralExprSyntax.self),
      let arity = Int(arityExpression.literal.trimmed.text),
      arity > 0
    else {
      throw ResettableError.why("Couldn't find arity!")
    }
    
    let typeName = "ChainCollection\(arity)Storage"
    
    let genericParameters = (1...arity)
      .map(algebraicTypeName(oneBasedIndex:))
    
    let typeParameters = "<\(genericParameters.joined(separator: ", "))>"
    
    
    let collectionDeclarations = genericParameters
      .lazy
      .map { "\($0): Collection" }
    
    let sameElementTypeCollections = genericParameters[1...]
      .map { "\($0).Element == \(genericParameters[0]).Element" }
    
    let whereClauseDeclarations = (collectionDeclarations + sameElementTypeCollections)
    
    let sendableDeclarations = genericParameters
      .lazy
      .map { "\($0): Sendable" }

    return [
      try DeclSyntax(validating: DeclSyntax(
        """
        internal final class \(raw: typeName)\(raw: typeParameters)
        where
        \(raw: whereClauseDeclarations.joined(separator: ",\n"))
        { }
        """
      )),
      
      try DeclSyntax(validating: DeclSyntax(
        """
        extension \(raw: typeName): @unchecked Sendable
        where
        \(raw: sendableDeclarations.joined(separator: ",\n"))
        { }
        """
      ))
    ]
  }
  
}

