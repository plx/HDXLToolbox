import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct StorageComparableMacro: ExtensionMacro {

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
    
    guard
      let visibilityLevel = declaration.visibilityLevel
    else {
      // TODO: import previous error utilities
      fatalError()
    }
    
    let operatorInlinabilityDisposition = InlinabilityDisposition.strongestAvailableInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: declaration.inlinabilityDisposition
    )

    let operatorInlinabilityText: String = operatorInlinabilityDisposition?.sourceCodeStringRepresentation ?? ""
    
    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : Comparable {
        
          \(raw: operatorInlinabilityText)
          \(visibilityLevel.tokenRepresentation()) static func < (
            lhs: Self,
            rhs: Self
          ) -> Bool {
            lhs.storage == rhs.storage
          }
        
        }
        """
      )
    ]
  }

}

