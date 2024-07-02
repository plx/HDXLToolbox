import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors

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
