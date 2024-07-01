import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddChainIndexFixedComponentsMacro { }

extension AddChainIndexFixedComponentsMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard
      let genericParameters = declaration.simpleGenericParameterNames,
      !genericParameters.isEmpty
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }

    return [
      """
      @usableFromInline
      internal typealias Position = Sum\(raw: genericParameters.count)<\(raw: genericParameters.joined(separator: ", "))>
      """,

      """
      @usableFromInline
      internal typealias Storage = PositionIndexStorage<Position>
      """,
      
      """
      @usableFromInline
      internal var storage: Storage
      """,
      
      """
      @inlinable
      internal init(storage: Storage) {
        self.storage = storage
      }
      """,
      
      """
      @inlinable
      internal init(position: Position) {
        self.init(
          storage: .position(position)
        )
      }
      """,
      
      """
      @inlinable
      internal static var endIndex: Self {
        Self(storage: .endIndex)
      }
      """
    ]
  }
}
