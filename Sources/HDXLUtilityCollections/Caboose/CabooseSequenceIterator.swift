import Foundation

@frozen
public struct CabooseSequenceIterator<Element, Base> where Base: IteratorProtocol<Element> {
  
  @usableFromInline
  internal var base: Base
    
  @usableFromInline
  internal let caboose: Element

  @usableFromInline
  internal var hasProvidedCaboose: Bool
  
  @inlinable
  internal init(
    base: Base,
    caboose: Element
  ) {
    self.base = base
    self.caboose = caboose
    self.hasProvidedCaboose = false
  }
  
}

extension CabooseSequenceIterator: IteratorProtocol {
  
  @inlinable
  public mutating func next() -> Element? {
    guard !hasProvidedCaboose else { return nil }
    
    switch base.next() {
    case .some(let nextBaseElement):
      return nextBaseElement
    case .none:
      hasProvidedCaboose = true
      return caboose
    }
  }
  
}
