import SwiftSyntax
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

/// ``MemberAttributeMacroContextProtocol`` refines``AttachedMacroContextProtocol`` and specializes it for member-attribute macros.
public protocol MemberAttributeMacroContextProtocol<Declaration, ExpansionContext, Member> : AttachedMacroContextProtocol
where Declaration: DeclGroupSyntax {
  associatedtype Member: DeclSyntaxProtocol
  
  var member: Member { get }
}
