import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: InterposeSequenceIterator - Definition
// ------------------------------------------------------------------------- //

@frozen
public struct InterposeSequenceIterator<BaseIterator>: IteratorProtocol where BaseIterator: IteratorProtocol {
  public typealias BaseElement = BaseIterator.Element
  public typealias Element = InterposeSequenceElement<BaseElement>
  
  @usableFromInline
  internal typealias Interposition = InterpositionElement<BaseIterator.Element>

  @usableFromInline
  internal enum IterationPosition {
    case initial
    case element(BaseElement)
    case interposition(Interposition)
    case exhausted
  }
  
  @usableFromInline
  internal var iterationPosition: IterationPosition = .initial
  
  @usableFromInline
  internal var baseIterator: BaseIterator
  
  @inlinable
  internal init(baseIterator: BaseIterator) {
    self.baseIterator = baseIterator
  }
  
  @inlinable
  public mutating func next() -> InterposeSequenceElement<BaseElement>? {
    switch iterationPosition {
    case .initial:
      guard let nextBaseElement = baseIterator.next() else {
        iterationPosition = .exhausted
        return nil
      }
      iterationPosition = .element(nextBaseElement)
      return .element(nextBaseElement)
    case .element(let previousBaseElement):
      guard let nextBaseElement = baseIterator.next() else {
        iterationPosition = .exhausted
        return nil
      }
      let interposition = Interposition(
        precedingElement: previousBaseElement,
        subsequentElement: nextBaseElement
      )
      iterationPosition = .interposition(interposition)
      return .interposition(interposition)
    case .interposition(let interposition):
      iterationPosition = .element(interposition.subsequentElement)
      return .element(interposition.subsequentElement)
    case .exhausted:
      return nil
    }
  }
}
