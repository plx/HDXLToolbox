import Foundation
import HDXLEssentialPrecursors

@frozen
public struct EndcapInterposeSequenceIterator<Intro,Outro,BaseIterator>: IteratorProtocol where BaseIterator: IteratorProtocol {
  public typealias BaseElement = BaseIterator.Element
  public typealias Element = EndcapInterposeSequenceElement<Intro,BaseElement,Outro>
  
  @usableFromInline
  internal typealias Interposition = InterpositionElement<BaseIterator.Element>

  @usableFromInline
  internal enum IterationPosition {
    case initial
    case intro
    case element(BaseElement)
    case interposition(Interposition)
    case outro
    case exhausted
  }
  
  @usableFromInline
  internal var iterationPosition: IterationPosition = .initial
  
  @usableFromInline
  internal let intro: Intro

  @usableFromInline
  internal let outro: Outro

  @usableFromInline
  internal var baseIterator: BaseIterator
  
  @inlinable
  internal init(
    intro: Intro,
    outro: Outro,
    baseIterator: BaseIterator
  ) {
    self.intro = intro
    self.outro = outro
    self.baseIterator = baseIterator
  }
  
  @inlinable
  public mutating func next() -> Element? {
    switch iterationPosition {
    case .initial:
      iterationPosition = .intro
      return .intro(intro)
    case .intro:
      guard let nextBaseElement = baseIterator.next() else {
        iterationPosition = .outro
        return .outro(outro)
      }
      iterationPosition = .element(nextBaseElement)
      return .element(nextBaseElement)
    case .element(let previousBaseElement):
      guard let nextBaseElement = baseIterator.next() else {
        iterationPosition = .outro
        return .outro(outro)
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
    case .outro:
      iterationPosition = .exhausted
      return nil
    case .exhausted:
      return nil
    }
  }
}
