import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

package let algebraicCharacters: [Character] = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
]

package func algebraicTypeName(oneBasedIndex: Int) -> String {
  precondition(oneBasedIndex > 0)
  let (baseCharacterIndex, additionalRepetitions) = (oneBasedIndex - 1).quotientAndRemainder(dividingBy: algebraicCharacters.count)
  return String(
    repeating: algebraicCharacters[baseCharacterIndex], 
    count: 1 + additionalRepetitions
  )
}

public struct CollectionsWithCommonElementTypeMacro: ExpressionMacro {

  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard
      let arityArgument = node.arguments.first,
      arityArgument.label?.text == "arity",
      let arityExpression = arityArgument.expression.as(IntegerLiteralExprSyntax.self),
      let arity = Int(arityExpression.literal.trimmed.text),
      arity > 0
    else {
      fatalError()
    }
    
    let genericParameters = (1...arity)
      .map(algebraicTypeName(oneBasedIndex:))
    
    let collectionDeclarations = genericParameters
      .lazy
      .map { "\($0): Collection" }
    
    let sameElementTypeCollections = genericParameters[1...]
      .map { "\($0).Element == \(genericParameters[0]).Element" }
    
    let whereClauseDeclarations = (collectionDeclarations + sameElementTypeCollections)
      .joined(separator: ", \n")
    
    return """
    \(raw: whereClauseDeclarations)
    """
  }
  
}

