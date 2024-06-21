import Foundation
import HDXLEssentialPrecursors

@frozen
public struct AdjacentPairAsyncIterator<Base>: AsyncIteratorProtocol where Base: AsyncIteratorProtocol {
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
  public mutating func next() async throws -> Element? {
    do {
      switch state {
      case .initial:
        guard
          let earlierElement = try await base.next(),
          let laterElement = try await base.next()
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
          let laterElement = try await base.next()
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
    catch let error {
      state = .exhausted
      throw error
    }
  }
}
