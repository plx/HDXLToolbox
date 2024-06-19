import Foundation
import HDXLEssentialPrecursors

public enum JSONSerializationKeyStrategy {
  case snakeCaseKeys
  case unmodifiedKeys
}

extension JSONSerializationKeyStrategy: Sendable { }
extension JSONSerializationKeyStrategy: Equatable { }
extension JSONSerializationKeyStrategy: Hashable { }
extension JSONSerializationKeyStrategy: CaseIterable { }
extension JSONSerializationKeyStrategy: Codable { }
extension JSONSerializationKeyStrategy: CustomStringConvertible { }
extension JSONSerializationKeyStrategy: CustomDebugStringConvertible { }

extension JSONSerializationKeyStrategy: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

extension JSONSerializationKeyStrategy: CaseNameAwareEnumeration {
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .snakeCaseKeys:
      "snakeCaseKeys"
    case .unmodifiedKeys:
      "unmodifiedKeys"
    }
  }
}
