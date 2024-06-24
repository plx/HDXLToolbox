import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

enum TempError : Error {
  case wrongArchetype
  case noMemberwiseInitializer
  case noVisibilityLevel
}

public struct ConstructorDebugDescriptionMacro: ExtensionMacro {
  
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
      typeDeclarationArchetype.isActorClassOrStruct
    else {
      throw TempError.wrongArchetype
//      // TODO: import previous error utilities
//      fatalError()
    }
    
    guard
      let memberwiseInitializer = declaration
        .memberBlock
        .members
        .compactMap({ $0.decl.as(InitializerDeclSyntax.self) })
        .first(where: \.isPreferredMemberwiseInitializer)
    else {
      throw TempError.noMemberwiseInitializer
//      // TODO: import previous error utilities
//      fatalError()
    }
    
    
    guard
      let visibilityLevel = declaration.visibilityLevel
    else {
      throw TempError.noVisibilityLevel
//      // TODO: import previous error utilities
//      fatalError()
    }
    
    let inlinabilityDisposition = InlinabilityDisposition.strongestAvailableInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: declaration.inlinabilityDisposition
    )
    
    let inlinabilityText: String = inlinabilityDisposition?.sourceCodeStringRepresentation ?? ""
    
    let constructorArgumentsClause = memberwiseInitializer
      .signature
      .parameterClause
      .parameters
      .map { parameter in
        (parameter.secondName ?? parameter.firstName).trimmed.text
      }
      .map { (parameterName) in
        String(repeating: " ", count: 8) + "(\"\(parameterName)\", \(parameterName))"
      }
      .joined(separator: ",\n")
    
    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : CustomDebugStringConvertible {
        
          \(raw: inlinabilityText)
          \(visibilityLevel.tokenRepresentation()) var debugDescription: String {
            String(
              forConstructorOf: Self.self,
              arguments: (
                \(raw: constructorArgumentsClause)
              )
            )
          }
        
        }
        """
      )
    ]
  }
  
}

