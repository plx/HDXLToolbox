import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct ConditionalAutoRawValueComparableMacro: ExtensionMacro {

  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    // TODO: reintroduce some attachment-site validation
    
    guard
      let typeDeclarationArchetype = declaration.typeDeclarationArchetype,
      typeDeclarationArchetype.isEnumClassOrStruct
    else {
      // TODO: import previous error utilities
      fatalError()
    }
    
    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : Comparable, AutoRawValueComparable where RawValue: Comparable { }
        """
      )
    ]
  }

}

