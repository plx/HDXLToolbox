import Foundation

extension JSONEncoder.KeyEncodingStrategy {
  @inlinable
  public init(_ strategy: JSONSerializationKeyStrategy) {
    switch strategy {
    case .snakeCaseKeys:
      self = .convertToSnakeCase
    case .unmodifiedKeys:
      self = .useDefaultKeys
    }
  }
}

extension JSONSerializationKeyStrategy {
  @inlinable
  public init?(_ strategy: JSONEncoder.KeyEncodingStrategy) {
    switch strategy {
    case .convertToSnakeCase:
      self = .snakeCaseKeys
    case .useDefaultKeys:
      self = .unmodifiedKeys
    case .custom(_):
      return nil
    @unknown default:
      return nil
    }
  }
}
