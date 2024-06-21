import Foundation

extension Sequence {
  @inlinable
  public func adjacentPairs() -> AdjacentPairSequence<Self> {
    AdjacentPairSequence<Self>(base: self)
  }
}
