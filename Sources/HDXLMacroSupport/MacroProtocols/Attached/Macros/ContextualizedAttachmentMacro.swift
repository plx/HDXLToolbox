import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import HDXLEssentialPrecursors
//import HDXLCollectionSupport

public protocol ContextualizedAttachedMacro: AttachedMacro, DiagnosticDomainAwareMacro {
  
  static var actorAttachmentDisposition: AttachmentDisposition { get }
  static var classAttachmentDisposition: AttachmentDisposition { get }
  static var enumAttachmentDisposition: AttachmentDisposition { get }
  static var structAttachmentDisposition: AttachmentDisposition { get }
  static var protocolAttachmentDisposition: AttachmentDisposition { get }
  
  static func _validateDeclarationArchetype(
    for attachmentContext: AttachedMacroContext<some DeclSyntaxProtocol, some MacroExpansionContext>,
    function: StaticString,
    fileID: StaticString,
    line: UInt,
    column: UInt
  ) throws
  
}

extension Set<DeclarationArchetype> {
  
  @inlinable
  internal mutating func insert(
    when dispositionRequirement: AttachmentDisposition,
    from pairs: some Sequence<(DeclarationArchetype, AttachmentDisposition)>
  ) {
    for (archetype, disposition) in pairs where disposition == dispositionRequirement {
      insert(archetype)
    }
  }
  
}

extension ContextualizedAttachedMacro {
  
  public static var actorAttachmentDisposition: AttachmentDisposition { .allowed }
  public static var classAttachmentDisposition: AttachmentDisposition { .allowed }
  public static var enumAttachmentDisposition: AttachmentDisposition { .allowed }
  public static var structAttachmentDisposition: AttachmentDisposition { .allowed }
  public static var protocolAttachmentDisposition: AttachmentDisposition { .allowed }
  
  @inlinable
  internal static func declarationArchetypes(forDisposition disposition: AttachmentDisposition) -> Set<DeclarationArchetype> {
    mutation(of: Set<DeclarationArchetype>()) {
      $0.insert(
        when: disposition,
        from: [
          (.actor, actorAttachmentDisposition),
          (.class, classAttachmentDisposition),
          (.enum, enumAttachmentDisposition),
          (.struct, structAttachmentDisposition),
          (.protocol, protocolAttachmentDisposition)
        ]
      )
    }
  }

  @inlinable
  public static var requiredAttachmentSiteArchetypes: Set<DeclarationArchetype>? {
    declarationArchetypes(
      forDisposition: .required
    ).unlessEmpty
  }
  
  @inlinable
  public static var excludedAttachmentSiteArchetypes: Set<DeclarationArchetype>? {
    declarationArchetypes(
      forDisposition: .required
    ).unlessEmpty
  }

}

extension ContextualizedAttachedMacro {
  
  public static func validateDeclarationArchetype(
    for attachmentContext: AttachedMacroContext<some DeclSyntaxProtocol, some MacroExpansionContext>,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws {
    try _validateDeclarationArchetype(
      for: attachmentContext,
      function: function,
      fileID: fileID,
      line: line,
      column: column
    )
  }

  public static func _validateDeclarationArchetype(
    for attachmentContext: AttachedMacroContext<some DeclSyntaxProtocol, some MacroExpansionContext>,
    function: StaticString,
    fileID: StaticString,
    line: UInt,
    column: UInt
  ) throws {
    if let requiredAttachmentSiteArchetypes {
      try attachmentContext.expansionRequirement(
        mustBeAttachedTo: requiredAttachmentSiteArchetypes,
        function: function,
        fileID: fileID,
        line: line,
        column: column
      )
    }
    
    if let excludedAttachmentSiteArchetypes {
      try attachmentContext.expansionRequirement(
        mustNotBeAttachedTo: excludedAttachmentSiteArchetypes,
        function: function,
        fileID: fileID,
        line: line,
        column: column
      )
    }
  }

}
