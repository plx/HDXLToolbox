import SwiftSyntax
import HDXLEssentialPrecursors

public enum InlinabilityContext {
  case typeDeclaration
  case storedPropertyDeclaration
  case functionOrMethodDeclaration
}

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
    inlinabilityContext: InlinabilityContext,
    visibilityLevel: VisibilityLevel,
    inlinabilityDisposition: InlinabilityDisposition?
  ) -> InlinabilityDisposition? {
    switch inlinabilityContext {
    case .typeDeclaration:
      strongestAvailableTypeDeclarationInlinability(
        visibilityLevel: visibilityLevel,
        inlinabilityDisposition: inlinabilityDisposition
      )
    case .storedPropertyDeclaration:
      strongestAvailableStoredPropertyInlinability(
        visibilityLevel: visibilityLevel,
        inlinabilityDisposition: inlinabilityDisposition
      )
    case .functionOrMethodDeclaration:
      strongestAvailableFunctionOrMethodInlinability(
        visibilityLevel: visibilityLevel,
        inlinabilityDisposition: inlinabilityDisposition
      )
    }
  }
  
  @inlinable
  public static func strongestAvailableFunctionOrMethodInlinability(
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

  @inlinable
  public static func strongestAvailableTypeDeclarationInlinability(
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
      return .usableFromInline
    case (.internal, .usableFromInline):
      return .usableFromInline
    case (.package, .none):
      return nil
    case (.package, .inlinable):
      return .usableFromInline
    case (.package, .usableFromInline):
      return .usableFromInline
    case (.public, _):
      return nil
    case (.open, _):
      return nil
    }
  }

  @inlinable
  public static func strongestAvailableStoredPropertyInlinability(
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
      return .usableFromInline
    case (.internal, .usableFromInline):
      return .usableFromInline
    case (.package, .none):
      return nil
    case (.package, .inlinable):
      return .usableFromInline
    case (.package, .usableFromInline):
      return .usableFromInline
    case (.public, _):
      return nil
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

