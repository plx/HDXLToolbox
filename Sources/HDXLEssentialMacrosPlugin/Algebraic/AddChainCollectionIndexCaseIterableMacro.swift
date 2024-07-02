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
  
  public static func expansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> [DeclSyntax] {
    
    // we deliberately only refer to `parameters.genericParameterNames` for this one
    let genericParameters = try attachmentContext.expansionRequirement(
      mustNotBeEmpty: parameters.genericParameterNames
    )
    
    return [
      """
      @inlinable
      public static var allCases: some Collection<Self> {
        ChainCollection(
          \(raw: genericParameters.map { "\($0).allCases.onDemandMap(Self.init(\($0.lowercased()):))" }.joined(separator: ",\n") )
        )
      }
      """
    ]
  }
  
}

