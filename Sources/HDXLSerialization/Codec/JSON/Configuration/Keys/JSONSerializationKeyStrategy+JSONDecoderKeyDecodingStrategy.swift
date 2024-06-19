import Foundation

extension JSONDecoder.KeyDecodingStrategy {
  @inlinable
  public init(_ strategy: JSONSerializationKeyStrategy) {
    switch strategy {
    case .snakeCaseKeys:
      self = .convertFromSnakeCase
    case .unmodifiedKeys:
      self = .useDefaultKeys
    }
  }
}

extension JSONSerializationKeyStrategy {
  @inlinable
  public init?(_ strategy: JSONDecoder.KeyDecodingStrategy) {
    switch strategy {
    case .convertFromSnakeCase:
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
