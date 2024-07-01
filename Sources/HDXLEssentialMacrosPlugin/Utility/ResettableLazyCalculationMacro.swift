import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport


/// ``ResettableLazyCalculationMacro`` implementing a "resettable calculation."
///
/// The basic idea is to capture this pattern:
///
/// ```swift
/// internal var _foo: Foo? = nil
///
/// internal func calculateFoo() -> Foo { /* possibly-expensive logic here */ }
///
/// internal var foo: Foo {
///   _foo.obtainAssuredValue(fallback: calculateFoo())
/// }
/// ```
///
/// In this case, this macro expects to be attached to a method declaration named `calculate$Thing`, and then:
///
/// - synthesizes a stored property like `var _$thing: Thing? = nil`
/// - synthesizes a computed property like `$thing: Thing` (that gets the cached thing if available, or recalculates-and-caches the value if unavailable).
public struct ResettableLazyCalculationMacro: DiagnosticDomainAwareMacro {}

extension ResettableLazyCalculationMacro: ContextualizedPeerMacro {
  
  public static let protocolAttachmentDisposition: AttachmentDisposition = .excluded
  public static let enumAttachmentDisposition: AttachmentDisposition = .excluded

  public static func contextualizedExpansion(
    in expansionContext: AttachedMacroContext<some DeclSyntaxProtocol, some MacroExpansionContext>
  ) throws -> [DeclSyntax] {
    
    let functionDeclaration = try expansionContext.expansionRequirement(
      declarationAs: FunctionDeclSyntax.self
    )
    
    let calculationType = try expansionContext.expansionRequirement(
      property: \.signature.returnClause?.type,
      of: functionDeclaration
    )
    
    let nameComponents = try expansionContext.expansionRequirement("Function name needs to match `calculate*`") {
      try /calculate(\w+)/.wholeMatch(in: functionDeclaration.name.text)
    }
        
    let variableName = String(lowercasingFirstCharacterOf: nameComponents.output.1)
    let storageVariableName = "_\(variableName)"
    
    return [
      """
      @usableFromInline
      internal var \(raw: storageVariableName): \(calculationType.trimmed)? = nil
      """,
      """
      @usableFromInline
      internal var \(raw: variableName): \(calculationType.trimmed) {
        \(raw: storageVariableName).obtainAssuredValue(
          fallback: \(raw: functionDeclaration.name.text)()
        )
      }
      """
    ]
  }

}

