import SwiftSyntax
import SwiftSyntaxMacros
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct COWStorageMacro : DiagnosticDomainAwareMacro {}

extension COWStorageMacro : ContextualizedAttachedMacro {
  
  public static let classAttachmentDisposition: AttachmentDisposition = .required
  
}

extension COWStorageMacro: ContextualizedExtensionMacro {
  
  public static func contextualizedExpansion(
    in attachmentContext: some ExtensionMacroContextProtocol
  ) throws -> [ExtensionDeclSyntax] {
    return [
      try ExtensionDeclSyntax(
        """
        extension \(attachmentContext.extendedType.trimmed): CloneableObject {
        
        }
        """
      )
    ]
  }
  
}

extension COWStorageMacro: ContextualizedMemberMacro {
  
  public static func contextualizedExpansion(
    in attachmentContext: some MemberMacroContextProtocol
  ) throws -> [DeclSyntax] {
    let classDeclaration = try attachmentContext.requireDeclaration(
      as: ClassDeclSyntax.self
    )
    
    let initializer = try attachmentContext.requireProperty(
      \.preferredDesignatedInitializerDeclarationIfAvailable,
       of: classDeclaration
    )
    
    let invocation = initializer
      .signature
      .parameterClause
      .parameters
      .lazy
      .map {
        (parameter)
        in
        let parameterName = parameter.secondName?.text ?? parameter.firstName.text
        let labelPortion = parameter.firstName.text == "_" ? "" : "\(parameter.firstName.text): "
        return "\(labelPortion)\(parameterName)"
      }
      .joined(separator: ", \n")
    
    return [
      """
      @inlinable
      internal func obtainClone() -> Self {
        Self(
          \(raw: invocation)
        )
      }
      """
    ]
  }
  
}
