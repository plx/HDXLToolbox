import Foundation

// -------------------------------------------------------------------------- //
// MARK: Fully-Configured Construction
// -------------------------------------------------------------------------- //

extension JSONEncoder {
  
  /// Constructs a `JSONEncoder` configured as-per the supplied arguments.
  ///
  /// - Parameters:
  ///   - keyEncodingStrategy: the strategy to use for converting Swift property names into json keys
  ///   - dateEncodingStrategy: the strategy to use for encoding `Date` values to JSON
  ///   - dataEncodingStrategy: the strategy to use for encoding `Data` values to JSON
  ///   - nonConformingFloatEncodingStrategy:the strategy to use for encoding non-conforming floats (e.g. infinity, negative infinity, and nan)
  ///   - outputFormatting: the formatting to apply to the output (e.g. compact, pretty-printed, etc.)
  ///
  /// - seealso: ``JSONSerializationConfiguration``
  /// - seealso: ``JSONDecoder.init(serializationConfiguration:)``
  @inlinable
  public convenience init(
    keyEncodingStrategy: KeyEncodingStrategy,
    dateEncodingStrategy: DateEncodingStrategy,
    dataEncodingStrategy: DataEncodingStrategy,
    nonConformingFloatEncodingStrategy: NonConformingFloatEncodingStrategy,
    outputFormatting: OutputFormatting
  ) {
    self.init()
    self.keyEncodingStrategy = keyEncodingStrategy
    self.dateEncodingStrategy = dateEncodingStrategy
    self.dataEncodingStrategy = dataEncodingStrategy
    self.nonConformingFloatEncodingStrategy = nonConformingFloatEncodingStrategy
    self.outputFormatting = outputFormatting
  }
}

// -------------------------------------------------------------------------- //
// MARK: JSONSerializationConfiguration Construction
// -------------------------------------------------------------------------- //

extension JSONEncoder {
  
  /// Constructs a `JSONEncoder` configured as-per `serializationConfiguration`.
  ///
  /// - seealso: ``JSONSerializationConfiguration``
  @inlinable
  public convenience init(serializationConfiguration: JSONSerializationConfiguration) {
    self.init(
      keyEncodingStrategy: KeyEncodingStrategy(serializationConfiguration.keyStrategy),
      dateEncodingStrategy: DateEncodingStrategy(serializationConfiguration.dateStrategy),
      dataEncodingStrategy: DataEncodingStrategy(serializationConfiguration.dataStrategy),
      nonConformingFloatEncodingStrategy: NonConformingFloatEncodingStrategy(serializationConfiguration.nonConformingFloatStrategy),
      outputFormatting: OutputFormatting(serializationConfiguration.formatOptions)
    )
  }
  
}
