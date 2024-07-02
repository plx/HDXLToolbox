import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

extension AttachedMacroContextProtocol where Declaration: DeclGroupSyntax {
  
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

