import Foundation

extension AsyncSequence {
  @inlinable
  public func asyncAdjacentPairs() -> AdjacentPairAsyncSequence<Self> {
    AdjacentPairAsyncSequence<Self>(base: self)
  }
}
