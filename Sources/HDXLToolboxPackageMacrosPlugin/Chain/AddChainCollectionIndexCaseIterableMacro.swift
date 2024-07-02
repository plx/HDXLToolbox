import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddChainCollectionIndexCaseIterableMacro: DiagnosticDomainAwareMacro {}

extension AddChainCollectionIndexCaseIterableMacro: SingleProtocolConditionalConformanceMacro {
  
  public static let associatedProtocol: String = "CaseIterable"
  
  public static func conditionalConformanceDeclarations(
    in attachmentContext: some ExtensionMacroContextProtocol,
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> [DeclSyntax] {
    
    // we deliberately only refer to `parameters.genericParameterNames` for this one
    let genericParameters = try attachmentContext.requireNonEmptyProperty(
      \.genericParameterNames,
       of: parameters
    )
    
    let indexComponentCases = genericParameters.map { genericParameter in
      let p = genericParameter.lowercased()
      let P = genericParameter
      
      return "\(P).allCases.onDemandMap(Self.init(\(p):))"
    }
    
    return [
      """
      @inlinable
      public static var allCases: some Collection<Self> {
        ChainCollection(
          \(raw: indexComponentCases.joined(separator: ",\n") )
        )
      }
      """
    ]
  }
  
}

