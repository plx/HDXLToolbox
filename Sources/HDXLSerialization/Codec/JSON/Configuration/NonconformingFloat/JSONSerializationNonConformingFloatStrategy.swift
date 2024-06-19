import Foundation
import HDXLEssentialPrecursors

public enum JSONSerializationNonConformingFloatStrategy {
  case `throw`
  case convertToString(NonConformingFloatMapping)
}

extension JSONSerializationNonConformingFloatStrategy: Sendable { }
extension JSONSerializationNonConformingFloatStrategy: Equatable { }
extension JSONSerializationNonConformingFloatStrategy: Hashable { }
extension JSONSerializationNonConformingFloatStrategy: Codable { }
extension JSONSerializationNonConformingFloatStrategy: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

extension JSONSerializationNonConformingFloatStrategy: CustomStringConvertible {
  @inlinable
  public var description: String {
    switch self {
    case .throw:
      ".throw"
    case .convertToString(let mapping):
      ".convertToString(\(String(describing: mapping)))"
    }
  }
}

extension JSONSerializationNonConformingFloatStrategy: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    switch self {
    case .throw:
      "JSONSerializationNonConformingFloatStrategy.throw"
    case .convertToString(let mapping):
      "JSONSerializationNonConformingFloatStrategy.convertToString(\(String(reflecting: mapping)))"
    }
  }
}

