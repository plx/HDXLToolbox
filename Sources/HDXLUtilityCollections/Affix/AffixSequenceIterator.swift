import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros
import HDXLCollectionSupport

@frozen
public struct AffixSequenceIterator<Base>: IteratorProtocol where Base: IteratorProtocol {
  public typealias Element = Base.Element
  
  @usableFromInline
  internal var prefixElement: Element?
  
  @usableFromInline
  internal var base: Base
  
  @usableFromInline
  internal var suffixElement: Element?
  
  @usableFromInline
  internal enum IterationState {
    case prefix
    case base
    case suffix
    case exhausted
  }

  @usableFromInline
  internal var state: IterationState = .prefix
  
  @inlinable
  internal init(
    prefixElement: Element?,
    base: Base,
    suffixElement: Element?
  ) {
    self.prefixElement = prefixElement
    self.base = base
    self.suffixElement = suffixElement
  }

  @inlinable
  public mutating func next() -> Element? {
    switch state {
    case .prefix:
      if let prefix = prefixElement {
        state = .base
        return prefix
      }
      fallthrough
    case .base:
      if let nextBase = base.next() {
        return nextBase
      }
      fallthrough
    case .suffix:
      state = .exhausted
      if let suffix = suffixElement {
        return suffix
      }
      fallthrough
    case .exhausted:
      return nil
    }
  }
}

