import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddAlgebraicProductLikeStringificationMacro: ExtensionMacro {
  
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    // TODO: reintroduce some attachment-site validation
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
    
    guard
      let nodeArguments = node.arguments,
      let labeledArgumentList = nodeArguments.as(LabeledExprListSyntax.self),
      let captionArgument = labeledArgumentList.first,
      let captionExpression = captionArgument.expression.as(StringLiteralExprSyntax.self)
    else {
      fatalError("real errors eventually!")
    }
    
    let constituentTupleText = genericParameters.map { $0.lowercased() }.joined(separator: ", ")

    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : CustomStringConvertible {
        
          @inlinable
          public var description: String {
            String(
              forCaption: \(captionExpression.trimmed),
              describingTuple: (
                \(raw: constituentTupleText)
              )
            )
          }
        
        }
        """
      ),
      
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : CustomDebugStringConvertible {
        
          @inlinable
          public var debugDescription: String {
            String(
              forConstructorOf: Self.self,
              unlabeledArguments: (
                \(raw: constituentTupleText)
              )
            )
          }
        
        }
        """
      )
    ]
  }
  
}

