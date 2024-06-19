import Foundation

extension JSONDecoder {
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

extension JSONDecoder {
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
