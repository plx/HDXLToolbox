import Foundation

extension SerializationCodec<Data> {
  @inlinable
  public init(jsonSerializationConfiguration serializationConfiguration: JSONSerializationConfiguration) {
    self.init(
      encoder: JSONEncoder(
        serializationConfiguration: serializationConfiguration
      ),
      decoder: JSONDecoder(
        serializationConfiguration: serializationConfiguration
      )
    )
  }
}
