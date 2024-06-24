import SwiftSyntax
import HDXLEssentialPrecursors

public enum VisibilityLevel {
  case `private`
  case `fileprivate`
  case `internal`
  case `package`
  case `public`
  case `open`
}

extension VisibilityLevel: Sendable {}
extension VisibilityLevel: Equatable {}
extension VisibilityLevel: Hashable {}
extension VisibilityLevel: Identifiable, AutoIdentifiable {}
extension VisibilityLevel: CaseIterable {}
extension VisibilityLevel: Codable {}
extension VisibilityLevel: CustomStringConvertible { }
extension VisibilityLevel: CustomDebugStringConvertible { }

extension VisibilityLevel: CaseNameAwareEnumeration {
  
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .private:
      "private"
    case .fileprivate:
      "fileprivate"
    case .internal:
      "internal"
    case .package:
      "package"
    case .public:
      "public"
    case .open:
      "open"
    }
  }
  
}

extension VisibilityLevel {
  
  @inlinable
  public func tokenRepresentation(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    TokenSyntax.keyword(
      keywordRepresentation,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia
    )
  }

  @inlinable
  public var keywordRepresentation: Keyword {
    switch self {
    case .private:
      .private
    case .fileprivate:
      .fileprivate
    case .internal:
      .internal
    case .package:
      .package
    case .public:
      .public
    case .open:
      .open
    }
  }

  @inlinable
  public var tokenKindRepresentation: TokenKind {
    .keyword(keywordRepresentation)
  }
  
}

