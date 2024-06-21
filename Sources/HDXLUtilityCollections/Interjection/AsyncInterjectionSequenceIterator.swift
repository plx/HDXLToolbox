import Foundation
import HDXLEssentialPrecursors

@frozen
public struct AsyncInterjectionSequenceIterator<Base>: AsyncIteratorProtocol where Base: AsyncIteratorProtocol {
  public typealias Element = Base.Element
  
  @usableFromInline
  internal typealias State = InterjectionSequenceIterationState<Element>
  
  @usableFromInline
  internal var interjection: Element
  
  @usableFromInline
  internal var base: Base
  
  @usableFromInline
  internal var state: State = .initial
  
  @inlinable
  internal init(
    interjection: Element,
    base: Base
  ) {
    self.interjection = interjection
    self.base = base
  }
  
  @inlinable
  public mutating func next() async throws -> Element? {
    do {
      switch state {
      case .initial:
        switch try await base.next() {
        case .some(let element):
          state = .element
          return element
        case .none:
          state = .exhausted
          return nil
        }
      case .element:
        switch try await base.next() {
        case .some(let nextElement):
          state = .interjection(nextElement)
          return interjection
        case .none:
          state = .exhausted
          return nil
        }
      case .interjection(let element):
        state = .element
        return element
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
