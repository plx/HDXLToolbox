import Foundation

extension JSONEncoder {
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

extension JSONEncoder {
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
