import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

//public struct COWWrapperMacro: ExtensionMacro {
//  public static func expansion(
//    of node: AttributeSyntax,
//    attachedTo declaration: some DeclGroupSyntax,
//    providingExtensionsOf type: some TypeSyntaxProtocol,
//    conformingTo protocols: [TypeSyntax],
//    in context: some MacroExpansionContext
//  ) throws -> [ExtensionDeclSyntax] {
//    [
//      try ExtensionDeclSyntax(
//        """
//        extension \(type.trimmed) : COWWrapperProtocol { }
//        """
//      )
//    ]
//  }
//  
//}

public struct COWWrapperMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    [
      """
      @inlinable
      internal mutating func ensureUniqueStorage() {
        guard !isKnownUniquelyReferenced(&storage) else { return }
        storage = storage.obtainClone()
      }
      """
    ]
  }
}
