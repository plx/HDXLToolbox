import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Arity2Position
// -------------------------------------------------------------------------- //

public enum Arity2Position : UInt8 {
  
  case a = 0b00000001
  case b = 0b00000010
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Properties
// -------------------------------------------------------------------------- //

extension Arity2Position: Sendable { }
extension Arity2Position: Equatable { }
extension Arity2Position: Hashable { }
extension Arity2Position: CaseIterable { }
extension Arity2Position: Codable { }
extension Arity2Position: CustomStringConvertible { }
extension Arity2Position: CustomDebugStringConvertible { }

extension Arity2Position: Comparable, AutoRawValueComparable { }
extension Arity2Position: Identifiable, AutoIdentifiable { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

extension Arity2Position: CaseNameAwareEnumeration {
  
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .a:
      "a"
    case .b:
      "b"
    }
  }
}
