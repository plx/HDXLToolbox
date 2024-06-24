import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: JSONSerializationDataStrategy
// -------------------------------------------------------------------------- //

/// Provides common terminology for "shared cases" of `JSONEncoder.DataEncodingStrategy` and `JSONDecoder.DataDecodingStrategy`.
public enum JSONSerializationDataStrategy {
  
  /// Let's `Data` choose the encoding strategy.
  case data
  
  /// Forces use of `base64`.
  case base64
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension JSONSerializationDataStrategy: Sendable { }
extension JSONSerializationDataStrategy: Equatable { }
extension JSONSerializationDataStrategy: Hashable { }
extension JSONSerializationDataStrategy: CaseIterable { }
extension JSONSerializationDataStrategy: Codable { }
extension JSONSerializationDataStrategy: Identifiable, AutoIdentifiable { }
extension JSONSerializationDataStrategy: CustomStringConvertible { }
extension JSONSerializationDataStrategy: CustomDebugStringConvertible { }

// -------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// -------------------------------------------------------------------------- //

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


