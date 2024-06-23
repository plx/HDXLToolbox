import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Arity4Position
// -------------------------------------------------------------------------- //

public enum Arity4Position : UInt8 {
  
  case a = 0b00000001
  case b = 0b00000010
  case c = 0b00000100
  case d = 0b00001000
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Properties
// -------------------------------------------------------------------------- //

extension Arity4Position: Sendable { }
extension Arity4Position: Equatable { }
extension Arity4Position: Hashable { }
extension Arity4Position: CaseIterable { }
extension Arity4Position: Codable { }
extension Arity4Position: CustomStringConvertible { }
extension Arity4Position: CustomDebugStringConvertible { }

extension Arity4Position: Comparable, AutoRawValueComparable { }
extension Arity4Position: Identifiable, AutoIdentifiable { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

extension Arity4Position: CaseNameAwareEnumeration {
  
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
    }
  }
}
