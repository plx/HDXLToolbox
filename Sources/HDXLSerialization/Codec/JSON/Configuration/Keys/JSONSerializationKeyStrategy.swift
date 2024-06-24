import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: JSONSerializationKeyStrategy
// -------------------------------------------------------------------------- //

/// Provides common terminology for "shared cases" of `JSONEncoder.KeyEncodingStrategy` and `JSONDecoder.KeyDecodingStrategy`.
public enum JSONSerializationKeyStrategy {
  
  /// Convert Swift property names to `snake_case`-style keys.
  case snakeCaseKeys
  
  /// Use unmodified Swift property names.
  case unmodifiedKeys
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension JSONSerializationKeyStrategy: Sendable { }
extension JSONSerializationKeyStrategy: Equatable { }
extension JSONSerializationKeyStrategy: Hashable { }
extension JSONSerializationKeyStrategy: CaseIterable { }
extension JSONSerializationKeyStrategy: Codable { }
extension JSONSerializationKeyStrategy: Identifiable, AutoIdentifiable { }
extension JSONSerializationKeyStrategy: CustomStringConvertible { }
extension JSONSerializationKeyStrategy: CustomDebugStringConvertible { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

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
