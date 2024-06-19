import Foundation

extension JSONEncoder.DateEncodingStrategy {
  @inlinable
  public init(_ strategy: JSONSerializationDateStrategy) {
    switch strategy {
    case .dateFormatting:
      self = .deferredToDate
    case .iso8601:
      self = .iso8601
    case .millisecondsSince1970:
      self = .millisecondsSince1970
    case .secondsSince1970:
      self = .secondsSince1970
    }
  }
}

extension JSONSerializationDateStrategy {
  @inlinable
  public init?(_ strategy: JSONEncoder.DateEncodingStrategy) {
    switch strategy {
    case .deferredToDate:
      self = .dateFormatting
    case .iso8601:
      self = .iso8601
    case .millisecondsSince1970:
      self = .millisecondsSince1970
    case .secondsSince1970:
      self = .secondsSince1970
    case .formatted(_):
      return nil
    case .custom(_):
      return nil
    @unknown default:
      return nil
    }
  }
}
