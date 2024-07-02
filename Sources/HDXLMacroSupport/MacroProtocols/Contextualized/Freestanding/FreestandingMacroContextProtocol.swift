import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

/// ``FreestandingMacroContextProtocol`` refines ``MacroContextProtocol`` and specializes it for use with the freestanding macros.
public protocol FreestandingMacroContextProtocol<ExpansionContext> : MacroContextProtocol
where MacroNode: FreestandingMacroExpansionSyntax
{ }
