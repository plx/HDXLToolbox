import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddAlgebraicProductLikeStringificationMacro: DiagnosticDomainAwareMacro { }

extension AddAlgebraicProductLikeStringificationMacro: UnconditionalConformanceMacro {
  public static let conformedProtocolNames: [String] = ["CustomStringConvertible", "CustomDebugStringConvertible"]
  
  public static func unconditionalExtensions(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [ExtensionDeclSyntax] {
    let genericParameters = try attachmentContext.expansionRequirement(
      nonEmptyProperty: \.simpleGenericParameterNames,
      of: attachmentContext.declaration
    )
    
    let labeledArgumentList = try attachmentContext.expansionRequirement(
      property: \.arguments,
      of: attachmentContext.attributeNode,
      as: LabeledExprListSyntax.self
    )
    
    let captionExpression = try attachmentContext.expansionRequirement(
      property: \.first,
      of: labeledArgumentList,
      as: StringLiteralExprSyntax.self
    )
    
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
