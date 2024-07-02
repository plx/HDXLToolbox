import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

/// ``DeclarationMacroContextProtocol`` refines ``FreestandingMacroContextProtocol`` and specializes it for use with declaration macros.
public protocol DeclarationMacroContextProtocol<ExpansionContext> : FreestandingMacroContextProtocol { }
