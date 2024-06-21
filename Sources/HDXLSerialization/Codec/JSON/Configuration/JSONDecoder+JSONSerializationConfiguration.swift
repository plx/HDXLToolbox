import Foundation

// -------------------------------------------------------------------------- //
// MARK: Fully-Configured Construction
// -------------------------------------------------------------------------- //

extension JSONDecoder {

  /// Constructs a `JSONDecoder` configured as-per the supplied arguments.
  ///
  /// - Parameters:
  ///   - keyDecodingStrategy: the strategy to use for converting Swift property names into json keys
  ///   - dateDecodingStrategy: the strategy to use for decoding `Date` values from JSON
  ///   - dataDecodingStrategy: the strategy to use for decoding `Data` values from JSON
  ///   - nonConformingFloatDecodingStrategy:the strategy to use for decoding non-conforming floats (e.g. infinity, negative infinity, and nan)
  ///   - allowsJSON5: whether we should attempt to decode data "JSON5"
  ///   - assumesTopLevelDictionary: whether we should assume the top level object is a dictionary 
  ///
  /// - seealso: ``JSONSerializationConfiguration``
  /// - seealso: ``JSONEncoder.init(serializationConfiguration:)``
  @inlinable
  public convenience init(
    keyDecodingStrategy: KeyDecodingStrategy,
    dateDecodingStrategy: DateDecodingStrategy,
    dataDecodingStrategy: DataDecodingStrategy,
    nonConformingFloatDecodingStrategy: NonConformingFloatDecodingStrategy,
    allowsJSON5: Bool,
    assumesTopLevelDictionary: Bool
  ) {
    self.init()
    self.keyDecodingStrategy = keyDecodingStrategy
    self.dateDecodingStrategy = dateDecodingStrategy
    self.dataDecodingStrategy = dataDecodingStrategy
    self.nonConformingFloatDecodingStrategy = nonConformingFloatDecodingStrategy
    self.allowsJSON5 = allowsJSON5
    self.assumesTopLevelDictionary = assumesTopLevelDictionary
  }
}

// -------------------------------------------------------------------------- //
// MARK: JSONSerializationConfiguration Construction
// -------------------------------------------------------------------------- //

extension JSONDecoder {
  
  /// Constructs a `JSONDecoder` configured as-per `serializationConfiguration`.
  ///
  /// - seealso: ``JSONSerializationConfiguration``
  /// - seealso: ``JSONEncoder.init(serializationConfiguration:)``
  @inlinable
  public convenience init(serializationConfiguration: JSONSerializationConfiguration) {
    self.init(
      keyDecodingStrategy: KeyDecodingStrategy(serializationConfiguration.keyStrategy),
      dateDecodingStrategy: DateDecodingStrategy(serializationConfiguration.dateStrategy),
      dataDecodingStrategy: DataDecodingStrategy(serializationConfiguration.dataStrategy),
      nonConformingFloatDecodingStrategy: NonConformingFloatDecodingStrategy(serializationConfiguration.nonConformingFloatStrategy),
      allowsJSON5: serializationConfiguration.formatOptions.shouldAllowJSON5,
      assumesTopLevelDictionary: serializationConfiguration.formatOptions.shouldAssumeTopLevelDictionary
    )
  }
  
}
