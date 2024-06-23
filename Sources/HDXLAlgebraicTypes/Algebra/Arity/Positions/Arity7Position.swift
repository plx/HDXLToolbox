import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Arity7Position
// -------------------------------------------------------------------------- //

public enum Arity7Position : UInt8 {
  
  case a = 0b00000001
  case b = 0b00000010
  case c = 0b00000100
  case d = 0b00001000
  case e = 0b00010000
  case f = 0b00100000
  case g = 0b01000000
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Properties
// -------------------------------------------------------------------------- //

extension Arity7Position: Sendable { }
extension Arity7Position: Equatable { }
extension Arity7Position: Hashable { }
extension Arity7Position: CaseIterable { }
extension Arity7Position: Codable { }
extension Arity7Position: CustomStringConvertible { }
extension Arity7Position: CustomDebugStringConvertible { }

extension Arity7Position: Comparable, AutoRawValueComparable { }
extension Arity7Position: Identifiable, AutoIdentifiable { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

extension Arity7Position: CaseNameAwareEnumeration {
  
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
    case .g:
      "g"
    }
  }
}
