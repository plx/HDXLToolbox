import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Arity9Position
// -------------------------------------------------------------------------- //

public enum Arity9Position : UInt16 {
  
  case a = 0b00000000_00000001
  case b = 0b00000000_00000010
  case c = 0b00000000_00000100
  case d = 0b00000000_00001000
  case e = 0b00000000_00010000
  case f = 0b00000000_00100000
  case g = 0b00000000_01000000
  case h = 0b00000000_10000000
  case i = 0b00000001_00000000

}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Properties
// -------------------------------------------------------------------------- //

extension Arity9Position: Sendable { }
extension Arity9Position: Equatable { }
extension Arity9Position: Hashable { }
extension Arity9Position: CaseIterable { }
extension Arity9Position: Codable { }
extension Arity9Position: CustomStringConvertible { }
extension Arity9Position: CustomDebugStringConvertible { }

extension Arity9Position: Comparable, AutoRawValueComparable { }
extension Arity9Position: Identifiable, AutoIdentifiable { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

extension Arity9Position: CaseNameAwareEnumeration {
  
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
    case .i:
      "i"
    }
  }
}
