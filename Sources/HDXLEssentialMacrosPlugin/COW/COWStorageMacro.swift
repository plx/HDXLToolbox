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
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [ExtensionDeclSyntax] {
    return [
      try ExtensionDeclSyntax(
        """
        extension \(type.trimmed): CloneableObject {
        
        }
        """
      )
    ]
  }
  
}

extension COWStorageMacro: ContextualizedMemberMacro {
  
  public static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [DeclSyntax] {
    let classDeclaration = try attachmentContext.expansionRequirement(
      declarationAs: ClassDeclSyntax.self
    )

    let initializerBlock = try attachmentContext.expansionRequirement(
      "declarationAs: ClassDeclSyntax.self"
    )
  }

  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard
      let classDeclaration = declaration.as(ClassDeclSyntax.self)
    else {
      // TODO: real errors!
      fatalError("This only works for classes!")
    }
    
    guard
      let initializerDeclarations = classDeclaration
        .memberBlock
        .members
        .compactMap({ (member) in
          member
            .decl
            .as(InitializerDeclSyntax.self)
        }).unlessEmpty
    else {
      fatalError("Couldn't find any initializers!")
    }
    
    let candidates = initializerDeclarations.filter { initializer in
      let isRequired = initializer.modifiers.anySatisfy { modifier in
        modifier.name.text == "required"
      }
      
      let isConvenience = initializer.modifiers.anySatisfy { modifier in
        modifier.name.text == "convenience"
      }
      
      return isRequired || !isConvenience
    }
    
    guard let initializer = candidates.first else {
      fatalError("Couldn't find any initializers!")
    }
    
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
