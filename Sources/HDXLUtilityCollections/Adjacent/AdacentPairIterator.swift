import Foundation
import HDXLEssentialPrecursors

@frozen
public struct AdjacentPairIterator<Base>: IteratorProtocol where Base: IteratorProtocol {
  public typealias Element = AdjacentPair<Base.Element>
  
  @usableFromInline
  internal typealias State = AdacentPairIterationState<Base.Element>
  
  @usableFromInline
  internal var base: Base
  
  @usableFromInline
  internal var state: State = .initial
  
  @inlinable
  internal init(base: Base) {
    self.base = base
  }
  
  @inlinable
  public mutating func next() -> Element? {
    switch state {
    case .initial:
      guard
        let earlierElement = base.next(),
        let laterElement = base.next()
      else {
        state = .exhausted
        return nil
      }
      state = .iterating(laterElement)
      return Element(
        earlierElement: earlierElement,
        laterElement: laterElement
      )
    case .iterating(let earlierElement):
      guard
        let laterElement = base.next()
      else {
        state = .exhausted
        return nil
      }
      state = .iterating(laterElement)
      return Element(
        earlierElement: earlierElement,
        laterElement: laterElement
      )
    case .exhausted:
      return nil
    }
  }
}
