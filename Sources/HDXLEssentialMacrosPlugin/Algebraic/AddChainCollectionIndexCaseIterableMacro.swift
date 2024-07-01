import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddChainCollectionIndexCaseIterableMacro: ExtensionMacro {  
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    guard
      let genericParameters = declaration.simpleGenericParameterNames,
      !genericParameters.isEmpty
    else {
      // TODO: real errors!
      fatalError("We'll be back!")
    }
    
    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed) : CaseIterable
        where
        \(raw: genericParameters.map { "\($0): CaseIterable " }.joined(separator: ",\n") )
        {
          @inlinable
          public static var allCases: some Collection<Self> {
            ChainCollection(
              \(raw: genericParameters.map { "\($0).allCases.onDemandMap(Self.init(\($0.lowercased()):))" }.joined(separator: ",\n") )
            )
          }

        }
        """
      )
    ]
  }
  
}

