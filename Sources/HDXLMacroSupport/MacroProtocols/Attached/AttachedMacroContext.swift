import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

public struct AttachedMacroContext<Declaration, ExpansionContext>
where
Declaration: DeclSyntaxProtocol,
ExpansionContext: MacroExpansionContext
{
  
  public var attributeNode: AttributeSyntax
  public var declaration: Declaration
  public var expansionContext: ExpansionContext
  public var diagnosticDomainIdentifier: String
  
  public init(
    attributeNode: AttributeSyntax,
    declaration: Declaration,
    expansionContext: ExpansionContext,
    diagnosticDomainIdentifier: String
  ) {
    self.attributeNode = attributeNode
    self.declaration = declaration
    self.expansionContext = expansionContext
    self.diagnosticDomainIdentifier = diagnosticDomainIdentifier
  }
}

extension AttachedMacroContext where Declaration: DeclGroupSyntax {
  
  public var explicitVisibilityLevel: VisibilityLevel? {
    declaration.visibilityLevel
  }
  
  public var visibilityLevel: VisibilityLevel {
    explicitVisibilityLevel ?? .internal
  }
  
  public var inlinabilityDisposition: InlinabilityDisposition? {
    declaration.inlinabilityDisposition
  }
  
  public var functionOrMethodGenerationDetails: (VisibilityLevel, InlinabilityDisposition?) {
    let visibilityLevel = visibilityLevel
    
    let inlinabilityDisposition = InlinabilityDisposition.strongestAvailableFunctionOrMethodInlinability(
      visibilityLevel: visibilityLevel,
      inlinabilityDisposition: declaration.inlinabilityDisposition
    )
    
    return (visibilityLevel, inlinabilityDisposition)
  }
}

extension AttachedMacroContext {
  
  package func withAutomaticRecordingForRequiredOperation<R>(
    messageIdentifier: @autoclosure () -> String,
    explanation: @autoclosure () -> String,
    subject: (any SyntaxProtocol)?,
    highlights: @autoclosure () -> [Syntax]? = nil,
    notes: @autoclosure () -> [Note] = [],
    fixIts: @autoclosure () -> [FixIt] = [],
    _ closure: () throws -> R
  ) throws -> R {
    do {
      return try closure()
    }
    catch let error {
      expansionContext.recordDiagnostic(
        for: declaration,
        subject: subject,
        severity: .error,
        domainID: diagnosticDomainIdentifier,
        messageID: messageIdentifier(),
        explanation: """
        `\(explanation())` failed w/error: \(error)
        """,
        highlights: highlights(),
        notes: notes(),
        fixIts: fixIts()
      )
      
      throw error
    }
  }
}
