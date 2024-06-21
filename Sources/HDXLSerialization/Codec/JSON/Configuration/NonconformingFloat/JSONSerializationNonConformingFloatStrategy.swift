import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: JSONSerializationNonConformingFloatStrategy
// -------------------------------------------------------------------------- //

/// Provides common terminology for of `JSONEncoder.NonConformingFloatEncodingStrategy` and `JSONDecoder.NonConformingFloatDecodingStrategy`.
public enum JSONSerializationNonConformingFloatStrategy {
  /// Throw an error when encountering non-conforming floats.
  case `throw`
  
  /// Convert non-conforming floats to strings as-per the associated ``NonConformingFloatMapping``,
  case convertToString(NonConformingFloatMapping)
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension JSONSerializationNonConformingFloatStrategy: Sendable { }
extension JSONSerializationNonConformingFloatStrategy: Equatable { }
extension JSONSerializationNonConformingFloatStrategy: Hashable { }
extension JSONSerializationNonConformingFloatStrategy: Codable { }
extension JSONSerializationNonConformingFloatStrategy: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

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

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

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

