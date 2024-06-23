import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Arity8Position
// -------------------------------------------------------------------------- //

public enum Arity8Position : UInt8 {
  
  case a = 0b00000001
  case b = 0b00000010
  case c = 0b00000100
  case d = 0b00001000
  case e = 0b00010000
  case f = 0b00100000
  case g = 0b01000000
  case h = 0b10000000
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Properties
// -------------------------------------------------------------------------- //

extension Arity8Position: Sendable { }
extension Arity8Position: Equatable { }
extension Arity8Position: Hashable { }
extension Arity8Position: CaseIterable { }
extension Arity8Position: Codable { }
extension Arity8Position: CustomStringConvertible { }
extension Arity8Position: CustomDebugStringConvertible { }

extension Arity8Position: Comparable, AutoRawValueComparable { }
extension Arity8Position: Identifiable, AutoIdentifiable { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

extension Arity8Position: CaseNameAwareEnumeration {
  
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
    case .h:
      "h"
    }
  }
}
