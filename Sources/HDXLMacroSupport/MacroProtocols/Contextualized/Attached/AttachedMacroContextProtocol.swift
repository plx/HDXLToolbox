import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: AttachedMacroContextProtocol
// -------------------------------------------------------------------------- //

/// ``AttachedMacroContextProtocol`` refines ``MacroContextProtocol`` and specializes it for use with the freestanding macros.
public protocol AttachedMacroContextProtocol<Declaration, ExpansionContext> : MacroContextProtocol
where MacroNode == AttributeSyntax
{
  
  /// The concrete syntax-type of the declaration to-which this macro was attached.
  associatedtype Declaration: DeclSyntaxProtocol
  
  var declaration: Declaration { get }
}
