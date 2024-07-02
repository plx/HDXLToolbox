import SwiftSyntax
import HDXLEssentialPrecursors

public enum TypeDeclarationArchetype {
  case `actor`
  case `class`
  case `enum`
  case `struct`
  case `protocol`
}

extension TypeDeclarationArchetype: Sendable { }
extension TypeDeclarationArchetype: Equatable { }
extension TypeDeclarationArchetype: Hashable { }
extension TypeDeclarationArchetype: Codable { }
extension TypeDeclarationArchetype: CaseIterable { }
extension TypeDeclarationArchetype: Identifiable, AutoIdentifiable { }

extension TypeDeclarationArchetype: CaseNameAwareEnumeration {
  
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .actor:
      "actor"
    case .enum:
      "enum"
    case .class:
      "class"
    case .struct:
      "struct"
    case .protocol:
      "protocol"
    }
  }
  
}

extension TypeDeclarationArchetype: CustomStringConvertible { }
extension TypeDeclarationArchetype: CustomDebugStringConvertible { }

extension TypeDeclarationArchetype {
  
  @inlinable
  public var isEnumClassOrStruct: Bool {
    switch self {
    case .actor:
      false
    case .class:
      true
    case .enum:
      true
    case .struct:
      true
    case .protocol:
      false
    }
  }
  
  @inlinable
  public var isActorClassOrStruct: Bool {
    switch self {
    case .actor:
      true
    case .class:
      true
    case .enum:
      false
    case .struct:
      true
    case .protocol:
      false
    }
  }
  
}