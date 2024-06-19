import Foundation
import HDXLEssentialPrecursors

public enum JSONSerializationDataStrategy {
  case data
  case base64
}

extension JSONSerializationDataStrategy: Sendable { }
extension JSONSerializationDataStrategy: Equatable { }
extension JSONSerializationDataStrategy: Hashable { }
extension JSONSerializationDataStrategy: CaseIterable { }
extension JSONSerializationDataStrategy: Codable { }
extension JSONSerializationDataStrategy: CustomStringConvertible { }
extension JSONSerializationDataStrategy: CustomDebugStringConvertible { }

extension JSONSerializationDataStrategy: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

extension JSONSerializationDataStrategy: CaseNameAwareEnumeration {
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .data:
      "data"
    case .base64:
      "base64"
    }
  }
}


