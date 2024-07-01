import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddAlgebraicProductLikeStorageAndForwardingMacro { }

extension AddAlgebraicProductLikeStorageAndForwardingMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard
      let structDeclaration = declaration.as(StructDeclSyntax.self)
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }
    
    guard
      let genericParameters = structDeclaration.simpleGenericParameterNames,
      !genericParameters.isEmpty
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }
    
    let genericParameterSuffix = "<\(genericParameters.joined(separator: ","))>"
    
    let typeName = structDeclaration.name.text
    let storageTypeName = "\(typeName)Storage\(genericParameterSuffix)"
    
    return [
      """
      @usableFromInline
      internal typealias Storage = \(raw: storageTypeName)
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
      @PreferredMemberwiseInitializer
      public init(
        \(raw: genericParameters.map { "_ \($0.lowercased()): \($0)" }.joined(separator: ",\n"))
      ) {
        self.init(
          storage: Storage(
            \(raw: genericParameters.map { "\($0.lowercased())" }.joined(separator: ",\n"))
          )
        )
      }
      """
    ] + genericParameters.map { genericParameter in
      """
      @inlinable
      @COWProperty
      public var \(raw: genericParameter.lowercased()): \(raw: genericParameter)
      """
    }
  }
}
