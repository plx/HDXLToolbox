import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Arity5Position
// -------------------------------------------------------------------------- //

public enum Arity5Position : UInt8 {
  
  case a = 0b00000001
  case b = 0b00000010
  case c = 0b00000100
  case d = 0b00001000
  case e = 0b00010000
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Properties
// -------------------------------------------------------------------------- //

extension Arity5Position: Sendable { }
extension Arity5Position: Equatable { }
extension Arity5Position: Hashable { }
extension Arity5Position: CaseIterable { }
extension Arity5Position: Codable { }
extension Arity5Position: CustomStringConvertible { }
extension Arity5Position: CustomDebugStringConvertible { }

extension Arity5Position: Comparable, AutoRawValueComparable { }
extension Arity5Position: Identifiable, AutoIdentifiable { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

extension Arity5Position: CaseNameAwareEnumeration {
  
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
    }
  }
}
