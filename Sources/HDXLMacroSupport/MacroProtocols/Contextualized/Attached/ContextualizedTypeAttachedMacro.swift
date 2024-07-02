import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

public protocol ContextualizedTypeAttachedMacro: ContextualizedAttachedMacro {
  
  static var actorAttachmentDisposition: AttachmentDisposition { get }
  static var classAttachmentDisposition: AttachmentDisposition { get }
  static var enumAttachmentDisposition: AttachmentDisposition { get }
  static var structAttachmentDisposition: AttachmentDisposition { get }
  static var protocolAttachmentDisposition: AttachmentDisposition { get }
  
}

extension ContextualizedTypeAttachedMacro {
  
  public static var actorAttachmentDisposition: AttachmentDisposition { .allowed }
  public static var classAttachmentDisposition: AttachmentDisposition { .allowed }
  public static var enumAttachmentDisposition: AttachmentDisposition { .allowed }
  public static var structAttachmentDisposition: AttachmentDisposition { .allowed }
  public static var protocolAttachmentDisposition: AttachmentDisposition { .allowed }
  
  @usableFromInline
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
      forDisposition: .excluded
    ).unlessEmpty
  }
  
  public static func validateDeclarationArchetype(
    for attachmentContext: some AttachedMacroContextProtocol
  ) throws {
    if let requiredAttachmentSiteArchetypes {
      try attachmentContext.requireDeclarationAttached(
        to: requiredAttachmentSiteArchetypes
      )
    }
    
    if let excludedAttachmentSiteArchetypes {
      try attachmentContext.requireDeclarationNotAttached(
        to: excludedAttachmentSiteArchetypes
      )
    }
  }
  
}

extension Set<DeclarationArchetype> {
  
  fileprivate mutating func insert(
    when dispositionRequirement: AttachmentDisposition,
    from pairs: some Sequence<(DeclarationArchetype, AttachmentDisposition)>
  ) {
    for (archetype, disposition) in pairs where disposition == dispositionRequirement {
      insert(archetype)
    }
  }
  
}

