import Foundation

extension JSONEncoder.NonConformingFloatEncodingStrategy {
  @inlinable
  public init(_ strategy: JSONSerializationNonConformingFloatStrategy) {
    switch strategy {
    case .throw:
      self = .throw
    case .convertToString(let nonConformingFloatMapping):
      self = .convertToString(
        positiveInfinity: nonConformingFloatMapping.positiveInfinity,
        negativeInfinity: nonConformingFloatMapping.negativeInfinity,
        nan: nonConformingFloatMapping.nan
      )
    }
  }
}

extension JSONSerializationNonConformingFloatStrategy {
  @inlinable
  public init?(_ strategy: JSONEncoder.NonConformingFloatEncodingStrategy) {
    switch strategy {
    case .throw:
      self = .throw
    case .convertToString(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
      self = .convertToString(
        NonConformingFloatMapping(
          positiveInfinity: positiveInfinity,
          negativeInfinity: negativeInfinity,
          nan: nan
        )
      )
    @unknown default:
      return nil
    }
  }
}
