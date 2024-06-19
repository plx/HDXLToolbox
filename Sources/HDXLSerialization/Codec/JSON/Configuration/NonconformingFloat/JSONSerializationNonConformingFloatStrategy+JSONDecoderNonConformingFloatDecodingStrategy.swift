import Foundation

extension JSONDecoder.NonConformingFloatDecodingStrategy {
  @inlinable
  public init(_ strategy: JSONSerializationNonConformingFloatStrategy) {
    switch strategy {
    case .throw:
      self = .throw
    case .convertToString(let nonConformingFloatMapping):
      self = .convertFromString(
        positiveInfinity: nonConformingFloatMapping.positiveInfinity,
        negativeInfinity: nonConformingFloatMapping.negativeInfinity,
        nan: nonConformingFloatMapping.nan
      )
    }
  }
}

extension JSONSerializationNonConformingFloatStrategy {
  @inlinable
  public init?(_ strategy: JSONDecoder.NonConformingFloatDecodingStrategy) {
    switch strategy {
    case .throw:
      self = .throw
    case .convertFromString(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
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
