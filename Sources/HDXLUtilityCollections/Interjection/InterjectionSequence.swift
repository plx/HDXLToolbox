import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

public typealias InterjectionCollection<Base> = InterjectionSequence<Base> where Base: Collection
public typealias InterjectionBidirectionalCollection<Base> = InterjectionSequence<Base> where Base: BidirectionalCollection
public typealias InterjectionRandomAccessCollection<Base> = InterjectionSequence<Base> where Base: RandomAccessCollection

extension Sequence {
  
  @inlinable
  public func interjected(by interjection: Element) -> some Sequence<Element> {
    return InterjectionSequence<Self>(
      interjection: interjection,
      base: self
    )
  }
}

@frozen
public struct InterjectionSequence<Base>: Sequence where Base: Sequence {
  public typealias Element = Base.Element
  public typealias Iterator = InterjectionSequenceIterator<Base.Iterator>
  
  @usableFromInline
  internal let interjection: Element
  
  @usableFromInline
  internal let base: Base
  
  @inlinable
  internal init(
    interjection: Element,
    base: Base
  ) {
    self.interjection = interjection
    self.base = base
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(
      interjection: interjection,
      base: base.makeIterator()
    )
  }
}

extension InterjectionSequence: Sendable where Base: Sendable, Base.Element: Sendable {}
extension InterjectionSequence: Equatable where Base: Equatable, Base.Element: Equatable {}
extension InterjectionSequence: Hashable where Base: Hashable, Base.Element: Hashable {}
extension InterjectionSequence: Encodable where Base: Encodable, Base.Element: Encodable {}
extension InterjectionSequence: Decodable where Base: Decodable, Base.Element: Decodable {}

extension InterjectionSequence: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "interjection-of \(String(describing: interjection)) within \(String(describing: base))"
  }
  
}

extension InterjectionSequence: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: type(of: self)))(interjection: \(String(reflecting: interjection)), base: \(String(reflecting: base)))"
  }
  
}

extension InterjectionSequence: Collection where Base: Collection {
  public typealias Index = InterjectionCollectionIndex<Base.Index>
  
  @inlinable
  public var isEmpty: Bool {
    base.isEmpty
  }
  
  @inlinable
  public var count: Int {
    base.count.impliedInterposeElementCount
  }
  
  @inlinable
  public var startIndex: Index {
    switch isEmpty {
    case true:
      endIndex
    case false:
      Index(index: base.startIndex)
    }
  }
  
  @inlinable
  public var endIndex: Index {
    .endIndex
  }
  
  //  @inlinable
  //  public func distance(
  //    from start: Index,
  //    to end: Index
  //  ) -> Int {
  //    switch (start.position, end.position) {
  //    case (.none, .none):
  //      return 0
  //    case (.some(.element(let startBaseIndex)), .none):
  //      return (2 * (
  //        base.distance(
  //          from: startBaseIndex,
  //          to: base.endIndex
  //        ))) - 1
  //    case (.some(.interposition(let startBaseInterposition)), .none):
  //        return
  //
  //    case (.some(.element(let startBaseIndex)), .some(.element(let endBaseIndex))):
  //      return 2 * base.distance(
  //        from: startBaseIndex,
  //        to: endBaseIndex
  //      )
  //    case (.some(.interposition(let startBaseInterposition)), .some(.interposition(let endBaseInterposition))):
  //      return 2 * base.distance(
  //        from: startBaseInterposition.precedingElement,
  //        to: endBaseInterposition.precedingElement
  //      )
  //    }
  //  }
  //
  @inlinable
  public subscript(index: Index) -> Element {
    guard let position = index.position else {
      fatalAttemptToSubscriptEndIndex(index)
    }
    switch position {
    case .element(let baseIndex):
      return base[baseIndex]
    case .interjection:
      return interjection
    }
  }
  
  @inlinable
  public func index(
    after i: Index
  ) -> Index {
    guard let position = i.position else {
      fatalAttemptToAdvanceEndIndex(i)
    }
    switch position {
    case .element(let baseIndex):
      let nextBaseIndex = base.index(after: baseIndex)
      switch nextBaseIndex == base.endIndex {
      case true:
        return .endIndex
      case false:
        return Index(
          interjection: Index.Interjection(
            precedingElement: baseIndex,
            subsequentElement: nextBaseIndex
          )
        )
      }
    case .interjection(let baseIndexInterjection):
      return Index(index: baseIndexInterjection.subsequentElement)
    }
  }
  
}

extension InterjectionSequence: BidirectionalCollection where Base: BidirectionalCollection {
  
  @inlinable
  public func index(
    before i: Index
  ) -> Index {
    switch i.position {
    case .none:
      guard let baseIndex = base.finalSubscriptableIndex else {
        fatalAttemptToGoBackFromStartIndex(i)
      }
      return Index(index: baseIndex)
    case .some(.element(let baseIndex)):
      return Index(
        interjection: Index.Interjection(
          precedingElement: base.index(before: baseIndex),
          subsequentElement: baseIndex
        )
      )
    case .some(.interjection(let baseInterjection)):
      return Index(index: baseInterjection.precedingElement)
    }
  }
}

extension InterjectionSequence: RandomAccessCollection where Base: RandomAccessCollection { }
