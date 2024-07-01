import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors

/// Base protocol for macros providing simplistic "all-or-none" conditional conformances.
///
/// The motivating use case is to reduce boilerplate like this:
///
/// ```swift
/// // note: no requirements here
/// struct Foo<Bar,Baz,Quux> {
///   var bar: Bar
///   var baz: Baz
///   var quux: Quux
/// }
///
/// // so tons of junk like this:
/// extension Foo: Sendable where Foo: Sendable, Bar: Sendable, Baz: Sendable { }
/// extension Foo: Equatable where Foo: Equatable, Bar: Equatable, Baz: Equatable { }
/// ```
///
/// The example there is this macro's sweet-spot: blindly applying identical conformance tests to each explicit
/// generic parameter.
///
/// I have some provisional support for richer semantics, but tbd if it works well or not.
public protocol AllOrNoneConditionalConformanceMacro: ContextualizedExtensionMacro, DiagnosticDomainAwareMacro {
    
  static var requiredProtocolNames: [String] { get }
  static var conformedProtocolNames: [String] { get }

  static func genericParameterNames(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [String]

  static func additionalImplicitGenericParameterNames(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    genericParameterNames: [String]
  ) throws -> [String]
 
  static func conditionalConformanceInheritanceClause(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> InheritanceClauseSyntax
  
  static func conditionalConformanceRequirementsClause(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> GenericWhereClauseSyntax

  static func conditionalConformanceDeclarations(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> [DeclSyntax]

  static func conditionalConformanceExtension(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> ExtensionDeclSyntax
}

extension AllOrNoneConditionalConformanceMacro {
  
  public static var additionalImplicitGenericParameterNames: [String] { [] }
  public static var protocolAttachmentDisposition: AttachmentDisposition { .excluded }
  
}

extension AllOrNoneConditionalConformanceMacro {
  public static func genericParameterNames(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [String] {
    let simpleGenericParameterNames = try attachmentContext.expansionRequirement(
      property: \.simpleGenericParameterNames,
      of: attachmentContext.declaration
    )
    
    return simpleGenericParameterNames
  }
  
  public static func additionalImplicitGenericParameterNames(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    genericParameterNames: [String]
  ) throws -> [String] {
    []
  }
  
  public static func conditionalConformanceInheritanceClause(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> InheritanceClauseSyntax {
    InheritanceClauseSyntax.forInheritedTypeNames(conformedProtocolNames)
  }
  
  public static func conditionalConformanceRequirementsClause(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> GenericWhereClauseSyntax {
    let allGenericParameterNames = try attachmentContext.expansionRequirement(
      mustNotBeEmpty: parameters.allGenericParameterNames
    )
    
    let requiredProtocolNames = try attachmentContext.expansionRequirement(
      mustNotBeEmpty: requiredProtocolNames
    )
    
    return GenericWhereClauseSyntax.withTransformedCartesianProduct(
      of: (allGenericParameterNames, requiredProtocolNames)
    ) { genericParameterName, requiredProtocolName in
      .requirement(
        that: genericParameterName,
        inheritsFrom: requiredProtocolName
      )
    }
  }
  
  public static func conditionalConformanceDeclarations(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> [DeclSyntax] {
    []
  }
  
  public static func conditionalConformanceExtension(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    parameters: AllOrNoneConditionalConformanceParameters
  ) throws -> ExtensionDeclSyntax {
    ExtensionDeclSyntax(
      extendedType: type,
      inheritanceClause: try conditionalConformanceInheritanceClause(
        in: attachmentContext,
        providingExtensionsOf: type,
        conformingTo: protocols,
        parameters: parameters
      ),
      genericWhereClause: try conditionalConformanceRequirementsClause(
        in: attachmentContext,
        providingExtensionsOf: type,
        conformingTo: protocols,
        parameters: parameters
      ),
      memberBlock: MemberBlockSyntax(
        declarations: try conditionalConformanceDeclarations(
          in: attachmentContext,
          providingExtensionsOf: type,
          conformingTo: protocols,
          parameters: parameters
        )
      )
    )
  }
}

extension AllOrNoneConditionalConformanceMacro where Self: ContextualizedExtensionMacro {
  
  public static func contextualizedExpansion(
    in attachmentContext: AttachedMacroContext<some DeclGroupSyntax, some MacroExpansionContext>,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax]
  ) throws -> [ExtensionDeclSyntax] {
    let genericParameterNames = try genericParameterNames(
      in: attachmentContext,
      providingExtensionsOf: type,
      conformingTo: protocols
    )
    
    let parameters = AllOrNoneConditionalConformanceParameters(
      genericParameterNames: genericParameterNames,
      additionalImplicitParameterNames: try additionalImplicitGenericParameterNames(
        in: attachmentContext,
        providingExtensionsOf: type,
        conformingTo: protocols,
        genericParameterNames: genericParameterNames
      ),
      visibilityLevel: attachmentContext.visibilityLevel,
      typeInlinabilityDisposition: InlinabilityDisposition.strongestAvailableTypeDeclarationInlinability(
        visibilityLevel: attachmentContext.visibilityLevel,
        inlinabilityDisposition: attachmentContext.inlinabilityDisposition
      ),
      methodInlinabilityDisposition: InlinabilityDisposition.strongestAvailableFunctionOrMethodInlinability(
        visibilityLevel: attachmentContext.visibilityLevel,
        inlinabilityDisposition: attachmentContext.inlinabilityDisposition
      )
    )

    return [
      try conditionalConformanceExtension(
        in: attachmentContext,
        providingExtensionsOf: type,
        conformingTo: protocols,
        parameters: parameters
      )
    ]
  }
      
}
