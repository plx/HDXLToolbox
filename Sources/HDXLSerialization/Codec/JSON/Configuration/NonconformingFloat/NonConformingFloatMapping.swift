import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros

@frozen
@ConstructorDebugDescription
public struct NonConformingFloatMapping {
  public var positiveInfinity: String
  public var negativeInfinity: String
  public var nan: String
  
  @inlinable
  @PreferredMemberwiseInitializer
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

extension NonConformingFloatMapping: Sendable {}
extension NonConformingFloatMapping: Equatable {}
extension NonConformingFloatMapping: Hashable {}
extension NonConformingFloatMapping: Codable {}
extension NonConformingFloatMapping: Identifiable, AutoIdentifiable {}

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
