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
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> [ExtensionDeclSyntax] {
    let genericParameters = try attachmentContext.requireNonEmptyProperty(
      \.simpleGenericParameterNames,
      of: attachmentContext.declaration
    )
    
    let labeledArgumentList = try attachmentContext.requireSyntaxProperty(
      \.arguments,
      of: attachmentContext.macroInvocationNode,
      as: LabeledExprListSyntax.self
    )
    
    let captionExpression = try attachmentContext.requireSyntaxProperty(
      \.first?.expression,
      of: labeledArgumentList,
      as: StringLiteralExprSyntax.self
    )
    
    let constituentTupleText = genericParameters.map { $0.lowercased() }.joined(separator: ", ")
    
    return [
      try ExtensionDeclSyntax(
        """
        extension \(attachmentContext.extendedType.trimmed) : CustomStringConvertible {
        
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
        extension \(attachmentContext.extendedType.trimmed) : CustomDebugStringConvertible {
        
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
