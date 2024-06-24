import SwiftSyntax
import HDXLEssentialPrecursors

public enum InlinabilityDisposition {
  case usableFromInline
  case inlinable
  
  @inlinable
  public init?(tokenSyntax: TokenSyntax) {
    switch tokenSyntax.text {
    case "usableFromInline":
      self = .usableFromInline
    case "inlinable":
      self = .inlinable
    default:
      return nil
    }
  }
  
  @inlinable
  public static func strongestAvailableInlinability(
    visibilityLevel: VisibilityLevel,
    inlinabilityDisposition: InlinabilityDisposition?
  ) -> InlinabilityDisposition? {
    switch (visibilityLevel, inlinabilityDisposition) {
    case (.private, _):
      return nil
    case (.fileprivate, _):
      return nil
    case (.internal, .none):
      return nil
    case (.internal, .inlinable):
      return .inlinable
    case (.internal, .usableFromInline):
      return .inlinable
    case (.package, .none):
      return nil
    case (.package, .inlinable):
      return .inlinable
    case (.package, .usableFromInline):
      return .inlinable
    case (.public, _):
      return .inlinable
    case (.open, _):
      return nil
    }
  }
  
}

extension InlinabilityDisposition: Sendable {}
extension InlinabilityDisposition: Equatable {}
extension InlinabilityDisposition: Hashable {}
extension InlinabilityDisposition: Identifiable, AutoIdentifiable {}
extension InlinabilityDisposition: CaseIterable {}
extension InlinabilityDisposition: Codable {}
extension InlinabilityDisposition: CustomStringConvertible { }
extension InlinabilityDisposition: CustomDebugStringConvertible { }

extension InlinabilityDisposition: CaseNameAwareEnumeration {
  
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .usableFromInline:
      "usableFromInline"
    case .inlinable:
      "inlinable"
    }
  }
  
}

extension InlinabilityDisposition {
  
  @inlinable
  public var sourceCodeStringRepresentation: String {
    switch self {
    case .usableFromInline:
      "@usableFromInline"
    case .inlinable:
      "@inlinable"
    }
  }
    
}

