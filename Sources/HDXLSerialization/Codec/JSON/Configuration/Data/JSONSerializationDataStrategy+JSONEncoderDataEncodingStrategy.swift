import Foundation

extension JSONEncoder.DataEncodingStrategy {
  @inlinable
  public init(_ strategy: JSONSerializationDataStrategy) {
    switch strategy {
    case .data:
      self = .deferredToData
    case .base64:
      self = .base64
    }
  }
}

extension JSONSerializationDataStrategy {
  @inlinable
  public init?(_ strategy: JSONEncoder.DataEncodingStrategy) {
    switch strategy {
    case .deferredToData:
      self = .data
    case .base64:
      self = .base64
    case .custom(_):
      return nil
    @unknown default:
      return nil
    }
  }
}
