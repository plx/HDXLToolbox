import Foundation

@frozen
public struct AdjacentPairAsyncSequence<Base>: AsyncSequence where Base: AsyncSequence {
  public typealias Element = AdjacentPair<Base.Element>
  
  public typealias AsyncIterator = AdjacentPairAsyncIterator<Base.AsyncIterator>
  
  @usableFromInline
  internal let base: Base
  
  @inlinable
  internal init(base: Base) {
    self.base = base
  }
  
  @inlinable
  public func makeAsyncIterator() -> AsyncIterator {
    AsyncIterator(base: base.makeAsyncIterator())
  }
  
}

