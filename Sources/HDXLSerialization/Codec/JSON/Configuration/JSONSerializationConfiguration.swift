import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: JSONSerializationConfiguration
// -------------------------------------------------------------------------- //

/// Holds complete configuration information for Apple's `JSONEncoder` and `JSONDecoder`.
@ConstructorDebugDescription
public struct JSONSerializationConfiguration {
  public var keyStrategy: JSONSerializationKeyStrategy
  public var dateStrategy: JSONSerializationDateStrategy
  public var dataStrategy: JSONSerializationDataStrategy
  public var nonConformingFloatStrategy: JSONSerializationNonConformingFloatStrategy
  public var formatOptions: JSONSerializationFormatOptions
  
  @inlinable
  @PreferredMemberwiseInitializer
  public init(
    keyStrategy: JSONSerializationKeyStrategy,
    dateStrategy: JSONSerializationDateStrategy,
    dataStrategy: JSONSerializationDataStrategy,
    nonConformingFloatStrategy: JSONSerializationNonConformingFloatStrategy,
    formatOptions: JSONSerializationFormatOptions
  ) {
    self.keyStrategy = keyStrategy
    self.dateStrategy = dateStrategy
    self.dataStrategy = dataStrategy
    self.nonConformingFloatStrategy = nonConformingFloatStrategy
    self.formatOptions = formatOptions
  }
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension JSONSerializationConfiguration: Sendable { }
extension JSONSerializationConfiguration: Equatable { }
extension JSONSerializationConfiguration: Hashable { }
extension JSONSerializationConfiguration: Codable { }
extension JSONSerializationConfiguration: Identifiable, AutoIdentifiable { }

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension JSONSerializationConfiguration: CustomStringConvertible {
  
  // TODO: these should be macro-generated / automatically-implemented
  @inlinable
  public var description: String {
    String(
      describingTuple: (
        keyStrategy,
        dataStrategy,
        dataStrategy,
        nonConformingFloatStrategy,
        formatOptions
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Derived-Value API
// -------------------------------------------------------------------------- //

extension JSONSerializationConfiguration {
  
  @inlinable
  internal func with<T>(
    _ keyPath: WritableKeyPath<Self, T>,
    updatedTo newValue: T
  ) -> Self {
    var clone = self
    clone[keyPath: keyPath] = newValue
    return clone
  }
  
  // TODO: this should come from a macro
  @inlinable
  public func with(keyStrategy: JSONSerializationKeyStrategy) -> JSONSerializationConfiguration {
    with(
      \.keyStrategy,
       updatedTo: keyStrategy
    )
  }
  
  // TODO: this should come from a macro
  @inlinable
  public func with(dateStrategy: JSONSerializationDateStrategy) -> JSONSerializationConfiguration {
    with(
      \.dataStrategy,
       updatedTo: dataStrategy
    )
  }
  
  // TODO: this should come from a macro
  @inlinable
  public func with(dataStrategy: JSONSerializationDataStrategy) -> JSONSerializationConfiguration {
    with(
      \.dataStrategy,
       updatedTo: dataStrategy
    )
  }
  
  // TODO: this should come from a macro
  @inlinable
  public func with(nonConformingFloatStrategy: JSONSerializationNonConformingFloatStrategy) -> JSONSerializationConfiguration {
    with(
      \.nonConformingFloatStrategy,
       updatedTo: nonConformingFloatStrategy
    )
  }
  
  // TODO: this should come from a macro
  @inlinable
  public func with(formatOptions: JSONSerializationFormatOptions) -> JSONSerializationConfiguration {
    with(
      \.formatOptions,
       updatedTo: formatOptions
    )
  }
  
}
