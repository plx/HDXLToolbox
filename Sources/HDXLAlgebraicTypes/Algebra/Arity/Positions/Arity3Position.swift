import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Arity3Position
// -------------------------------------------------------------------------- //

public enum Arity3Position : UInt8 {
  
  case a = 0b00000001
  case b = 0b00000010
  case c = 0b00000100
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Properties
// -------------------------------------------------------------------------- //

extension Arity3Position: Sendable { }
extension Arity3Position: Equatable { }
extension Arity3Position: Hashable { }
extension Arity3Position: CaseIterable { }
extension Arity3Position: Codable { }
extension Arity3Position: CustomStringConvertible { }
extension Arity3Position: CustomDebugStringConvertible { }

extension Arity3Position: Comparable, AutoRawValueComparable { }
extension Arity3Position: Identifiable, AutoIdentifiable { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

extension Arity3Position: CaseNameAwareEnumeration {
  
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .a:
      "a"
    case .b:
      "b"
    case .c:
      "c"
    }
  }
}
