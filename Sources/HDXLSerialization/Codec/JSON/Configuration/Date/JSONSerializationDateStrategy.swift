import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: JSONSerializationDateStrategy
// -------------------------------------------------------------------------- //

/// Provides common terminology for "shared cases" of `JSONEncoder.DateEncodingStrategy` and `JSONDecoder.DateDecodingStrategy`.
///
/// - Note: this deliberately does *not* include an equivalent of the `.custom(_)` case.
public enum JSONSerializationDateStrategy {
  case dateFormatting
  case iso8601
  case millisecondsSince1970
  case secondsSince1970
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension JSONSerializationDateStrategy: Sendable { }
extension JSONSerializationDateStrategy: Equatable { }
extension JSONSerializationDateStrategy: Hashable { }
extension JSONSerializationDateStrategy: CaseIterable { }
extension JSONSerializationDateStrategy: Codable { }
extension JSONSerializationDateStrategy: CustomStringConvertible { }
extension JSONSerializationDateStrategy: CustomDebugStringConvertible { }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension JSONSerializationDateStrategy: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

extension JSONSerializationDateStrategy: CaseNameAwareEnumeration {
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .dateFormatting:
      "dateFormatting"
    case .iso8601:
      "iso8601"
    case .millisecondsSince1970:
      "millisecondsSince1970"
    case .secondsSince1970:
      "secondsSince1970"
    }
  }
}

