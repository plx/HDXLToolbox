import HDXLEssentialPrecursors

public enum AttachmentDisposition {
  case allowed
  case required
  case excluded
}

extension AttachmentDisposition: Sendable { }
extension AttachmentDisposition: Equatable { }
extension AttachmentDisposition: Hashable { }
extension AttachmentDisposition: Identifiable, AutoIdentifiable { }
extension AttachmentDisposition: CaseIterable { }
extension AttachmentDisposition: Codable { }

extension AttachmentDisposition: CaseNameAwareEnumeration {
  
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .allowed:
      "allowed"
    case .required:
      "required"
    case .excluded:
      "excluded"
    }
  }
  
}

extension AttachmentDisposition: CustomStringConvertible { }
extension AttachmentDisposition: CustomDebugStringConvertible { }
