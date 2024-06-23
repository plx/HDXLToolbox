import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Arity6Position
// -------------------------------------------------------------------------- //

public enum Arity6Position : UInt8 {
  
  case a = 0b00000001
  case b = 0b00000010
  case c = 0b00000100
  case d = 0b00001000
  case e = 0b00010000
  case f = 0b00100000
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Properties
// -------------------------------------------------------------------------- //

extension Arity6Position: Sendable { }
extension Arity6Position: Equatable { }
extension Arity6Position: Hashable { }
extension Arity6Position: CaseIterable { }
extension Arity6Position: Codable { }
extension Arity6Position: CustomStringConvertible { }
extension Arity6Position: CustomDebugStringConvertible { }

extension Arity6Position: Comparable, AutoRawValueComparable { }
extension Arity6Position: Identifiable, AutoIdentifiable { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

extension Arity6Position: CaseNameAwareEnumeration {
  
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .a:
      "a"
    case .b:
      "b"
    case .c:
      "c"
    case .d:
      "d"
    case .e:
      "e"
    case .f:
      "f"
    }
  }
}
