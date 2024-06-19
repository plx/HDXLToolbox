import Foundation
import HDXLEssentialPrecursors

public enum JSONSerializationDateStrategy {
  case dateFormatting
  case iso8601
  case millisecondsSince1970
  case secondsSince1970
}

extension JSONSerializationDateStrategy: Sendable { }
extension JSONSerializationDateStrategy: Equatable { }
extension JSONSerializationDateStrategy: Hashable { }
extension JSONSerializationDateStrategy: CaseIterable { }
extension JSONSerializationDateStrategy: Codable { }
extension JSONSerializationDateStrategy: CustomStringConvertible { }
extension JSONSerializationDateStrategy: CustomDebugStringConvertible { }

extension JSONSerializationDateStrategy: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

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

