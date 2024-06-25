import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

public typealias AffixCollection<Base> = AffixSequence<Base> where Base: Collection
public typealias AffixBidirectionalCollection<Base> = AffixSequence<Base> where Base: BidirectionalCollection
public typealias AffixRandomAccessCollection<Base> = AffixSequence<Base> where Base: RandomAccessCollection

extension Sequence {
  @inlinable
  public func withAffixes(
    prefixElement: Element?,
    suffixElement: Element?
  ) -> some Sequence<Element> {
    AffixSequence<Self>(
      prefixElement: prefixElement,
      base: self,
      suffixElement: suffixElement
    )
  }
  
  @inlinable
  public func withPrefixElement(_ prefixElement: Element) -> some Sequence<Element> {
    AffixSequence<Self>(
      prefixElement: prefixElement,
      base: self,
      suffixElement: nil
    )
  }
  
  @inlinable
  public func withSuffixElement(_ suffixElement: Element) -> some Sequence<Element> {
    AffixSequence<Self>(
      prefixElement: nil,
      base: self,
      suffixElement: suffixElement
    )
  }
}

@frozen
public struct AffixSequence<Base>: Sequence where Base: Sequence {
  public typealias Element = Base.Element
  public typealias Iterator = AffixSequenceIterator<Base.Iterator>
  
  @usableFromInline
  internal let prefixElement: Element?
  
  @usableFromInline
  internal let base: Base

  @usableFromInline
  internal let suffixElement: Element?
  
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
  public func makeIterator() -> Iterator {
    Iterator(
      prefixElement: prefixElement,
      base: base.makeIterator(),
      suffixElement: prefixElement
    )
  }
  
  @inlinable
  public var underestimatedCount: Int {
    prefixElement.oneIfPresent
    +
    base.underestimatedCount
    +
    suffixElement.oneIfPresent
  }
}

extension AffixSequence: Sendable where Base: Sendable, Base.Element: Sendable { }
extension AffixSequence: Equatable where Base: Equatable, Base.Element: Equatable { }
extension AffixSequence: Hashable where Base: Hashable, Base.Element: Hashable { }
extension AffixSequence: Encodable where Base: Encodable, Base.Element: Encodable { }
extension AffixSequence: Decodable where Base: Decodable, Base.Element: Decodable { }

extension AffixSequence: Collection where Base: Collection {
  public typealias Index = AffixCollectionIndex<Base.Index>
  
  @usableFromInline
  internal typealias Position = AffixCollectionPosition<Base.Index>
  
  @inlinable
  public var isEmpty: Bool {
    prefixElement == nil
    &&
    suffixElement == nil
    &&
    base.isEmpty
  }
  
  @inlinable
  public var count: Int {
    prefixElement.oneIfPresent
    +
    base.count
    +
    suffixElement.oneIfPresent
  }
  
  @inlinable
  public var startIndex: Index {
    if prefixElement != nil {
      .prefix
    } else if !base.isEmpty {
      Index(baseIndex: base.startIndex)
    } else if suffixElement != nil {
      .suffix
    } else {
      endIndex
    }
  }
  
  @inlinable
  public var endIndex: Index {
    .endIndex
  }
  
  @inlinable
  internal func mandatoryElement(forIndex index: Index) -> Element {
    guard let position = index.position else {
      fatalAttemptToSubscriptEndIndex(index)
    }
    switch position {
    case .prefix:
      guard let prefixElement = prefixElement else {
        fatalError("Mistakenly subscripted an absent prefix element on \(String(reflecting: self))!")
      }
      return prefixElement
    case .base(let baseIndex):
      return base[baseIndex]
    case .suffix:
      guard let suffixElement = suffixElement else {
        fatalError("Mistakenly subscripted an absent suffix element on \(String(reflecting: self))!")
      }
      return suffixElement
    }
  }
  
  @inlinable
  public subscript(position: Index) -> Element {
    mandatoryElement(forIndex: position)
  }
  
  @inlinable
  public func distance(
    from start: AffixCollectionIndex<Base.Index>,
    to end: AffixCollectionIndex<Base.Index>
  ) -> Int {
    linearIndex(forIndex: end)
    -
    linearIndex(forIndex: start)
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    guard let position = i.position else {
      fatalAttemptToAdvanceEndIndex(i)
    }
    switch position {
    case .prefix:
      if let firstInBase = base.firstSubscriptableIndex {
        return Index(baseIndex: firstInBase)
      } else if suffixElement != nil {
        return .suffix
      } else {
        return .endIndex
      }
    case .base(let baseIndex):
      switch base.subscriptableIndex(after: baseIndex) {
      case .some(let nextBaseIndex):
        return Index(baseIndex: nextBaseIndex)
      case .none:
        if suffixElement != nil {
          return .prefix
        } else {
          return .endIndex
        }
      }
    case .suffix:
      return .endIndex
    }
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int
  ) -> Index {
    index(
      forLinearIndex: (
        linearIndex(
          forIndex: i
        )
        +
        distance
      )
    )
  }
  
  @inlinable
  internal func linearIndex(forPosition position: Position) -> Int {
    switch position {
    case .prefix:
      0
    case .base(let baseIndex):
      prefixElement.oneIfPresent
      +
      base.distance(
        from: base.startIndex,
        to: baseIndex
      )
    case .suffix:
      prefixElement.oneIfPresent
      +
      base.count
    }
  }
  
  @inlinable
  internal func linearIndex(forIndex index: Index) -> Int {
    switch index.position {
    case .some(let position):
      linearIndex(forPosition: position)
    case .none:
      count
    }
  }
  
  @inlinable
  internal func mandatoryPosition(forLinearIndex linearIndex: Int) -> Position {
    if linearIndex == 0 && prefixElement != nil {
      return .prefix
    } else {
      let baseCount = base.count
      let adjustedIndex = linearIndex - prefixElement.oneIfPresent
      if adjustedIndex < baseCount {
        return .base(
          base.index(
            base.startIndex,
            offsetBy: adjustedIndex
          )
        )
      } else if suffixElement != nil && adjustedIndex == baseCount {
        return .suffix
      } else {
        fatalError("Tried to convert get a mandatory position from a linear index \(linearIndex) with no such equivalent position in \(String(reflecting: self))!")
      }
    }
  }
  
  @inlinable
  internal func index(forLinearIndex linearIndex: Int) -> Index {
    switch linearIndex == count {
    case true:
      .endIndex
    case false:
      Index(position: mandatoryPosition(forLinearIndex: linearIndex))
    }
  }
  
}

extension AffixSequence: BidirectionalCollection where Base: BidirectionalCollection {
  @inlinable
  public func index(before i: Index) -> Index {
    switch i.position {
    case .none:
      if suffixElement != nil {
        return .suffix
      } else if let final = base.finalSubscriptableIndex {
        return Index(baseIndex: final)
      } else if prefixElement != nil {
        return .prefix
      } else {
        fatalAttemptToGoBackFromStartIndex(i)
      }
    case .some(let position):
      switch position {
      case .prefix:
        fatalAttemptToGoBackFromStartIndex(i)
      case .base(let baseIndex):
        if let previous = base.subscriptableIndex(before: baseIndex) {
          return Index(baseIndex: previous)
        } else if prefixElement != nil {
          return .prefix
        } else {
          fatalAttemptToGoBackFromStartIndex(i)
        }
      case .suffix:
        if let final = base.finalSubscriptableIndex {
          return Index(baseIndex: final)
        } else if prefixElement != nil {
          return .prefix
        } else {
          fatalAttemptToGoBackFromStartIndex(i)
        }
      }
    }
  }
}

extension AffixSequence: RandomAccessCollection where Base: RandomAccessCollection { }
