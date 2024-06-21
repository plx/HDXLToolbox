import Foundation

extension SerializationCodec<Data> {
  
  /// Obtains a serialization codec that serializes JSON to-and-from `Data` as per `serializationConfiguration`.
  ///
  /// - seealso: ``JSONSerializationConfiguration``
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
