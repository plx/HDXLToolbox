import Foundation
import HDXLEssentialPrecursors

@frozen
public struct NonConformingFloatMapping {
  public var positiveInfinity: String
  public var negativeInfinity: String
  public var nan: String
  
  @inlinable
  public init(
    positiveInfinity: String,
    negativeInfinity: String,
    nan: String
  ) {
    self.positiveInfinity = positiveInfinity
    self.negativeInfinity = negativeInfinity
    self.nan = nan
  }
}

extension NonConformingFloatMapping: Equatable {}
extension NonConformingFloatMapping: Hashable {}
extension NonConformingFloatMapping: Codable {}
extension NonConformingFloatMapping: Sendable {}
extension NonConformingFloatMapping: Identifiable { 
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

extension NonConformingFloatMapping: CustomStringConvertible {
  @inlinable
  public var description: String {
    String(
      describingLabeledTuple: (
        ("∞", positiveInfinity),
        ("-∞", negativeInfinity),
        ("nan", nan)
      )
    )
  }
}

extension NonConformingFloatMapping: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      arguments: (
        ("positiveInfinity", positiveInfinity),
        ("negativeInfinity", negativeInfinity),
        ("nan", nan)
      )
    )
  }
}
