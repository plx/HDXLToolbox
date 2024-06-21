import Foundation
import HDXLEssentialPrecursors

@frozen
public struct InterjectionSequenceIterator<Base>: IteratorProtocol where Base: IteratorProtocol {
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
  public mutating func next() -> Element? {
    switch state {
    case .initial:
      switch base.next() {
      case .some(let element):
        state = .element
        return element
      case .none:
        state = .exhausted
        return nil
      }
    case .element:
      switch base.next() {
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
}
