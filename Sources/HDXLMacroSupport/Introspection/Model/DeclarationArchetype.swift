import HDXLEssentialPrecursors

public enum DeclarationArchetype {
  case accessor
  case `actor`
  case `associatedtype`
  case `class`
  case deinitializer
  case editorPlaceholder
  case enumCase
  case `enum`
  case `extension`
  case function
  case ifConfig
  case `import`
  case initializer
  case `macro`
  case macroExpansion
  case missing
  case `operator`
  case poundSourceLocation
  case precedenceGroup
  case `protocol`
  case `struct`
  case `subscript`
  case `typealias`
  case variable
}

extension DeclarationArchetype: Sendable { }
extension DeclarationArchetype: Equatable { }
extension DeclarationArchetype: Hashable { }
extension DeclarationArchetype: Codable { }
extension DeclarationArchetype: CaseIterable { }
extension DeclarationArchetype: Identifiable, AutoIdentifiable { }

extension DeclarationArchetype: CaseNameAwareEnumeration {
  
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .accessor:
      "accessor"
    case .actor:
      "actor"
    case .associatedtype:
      "associatedtype"
    case .class:
      "class"
    case .deinitializer:
      "deinitializer"
    case .editorPlaceholder:
      "editorPlaceholder"
    case .enumCase:
      "enumCase"
    case .enum:
      "enum"
    case .extension:
      "extension"
    case .function:
      "function"
    case .ifConfig:
      "ifConfig"
    case .import:
      "import"
    case .initializer:
      "initializer"
    case .macro:
      "macro"
    case .macroExpansion:
      "macroExpansion"
    case .missing:
      "missing"
    case .operator:
      "operator"
    case .poundSourceLocation:
      "poundSourceLocation"
    case .precedenceGroup:
      "precedenceGroup"
    case .protocol:
      "protocol"
    case .struct:
      "struct"
    case .subscript:
      "subscript"
    case .typealias:
      "typealias"
    case .variable:
      "variable"
    }
  }
  
}

extension DeclarationArchetype: CustomStringConvertible { }
extension DeclarationArchetype: CustomDebugStringConvertible { }
