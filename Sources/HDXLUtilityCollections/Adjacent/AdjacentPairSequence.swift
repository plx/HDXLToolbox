import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

public typealias AdjacentPairCollection<Base> = AdjacentPairSequence<Base> where Base: Collection
public typealias AdjacentPairBidirectionalCollection<Base> = AdjacentPairSequence<Base> where Base: BidirectionalCollection
public typealias AdjacentPairRandomAccessCollection<Base> = AdjacentPairSequence<Base> where Base: RandomAccessCollection

@frozen
public struct AdjacentPairSequence<Base>: Sequence where Base: Sequence {
  public typealias Iterator = AdjacentPairIterator<Base.Iterator>
  
  @usableFromInline
  internal let base: Base
  
  @inlinable
  internal init(base: Base) {
    self.base = base
  }
  
  @inlinable
  public var underestimatedCount: Int {
    Swift.max(0, base.underestimatedCount - 1)
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(base: base.makeIterator())
  }
  
}

extension AdjacentPairSequence: Sendable where Base: Sendable { }
extension AdjacentPairSequence: Equatable where Base: Equatable { }
extension AdjacentPairSequence: Hashable where Base: Hashable { }
extension AdjacentPairSequence: Encodable where Base: Encodable { }
extension AdjacentPairSequence: Decodable where Base: Decodable { }

extension AdjacentPairSequence: Collection where Base: Collection {
  public typealias Index = AdjacentPairCollectionIndex<Base.Index>
  public typealias SubSequence = AdjacentPairSequence<Base.SubSequence>
  
  @inlinable
  public var isEmpty: Bool {
    return base.isEmpty || count <= 0
  }
  
  @inlinable
  public var count: Int {
    return Swift.max(0, base.count - 1)
  }
  
  @inlinable
  public var startIndex: Index {
    let firstIndex = base.startIndex
    guard firstIndex != base.endIndex else {
      return .endIndex
    }
    let secondIndex = base.index(after: firstIndex)
    guard secondIndex != base.endIndex else {
      return .endIndex
    }
    return Index(
      earlierIndex: firstIndex,
      laterIndex: secondIndex
    )
  }
  
  @inlinable
  public var endIndex: Index { .endIndex }
  
  @inlinable
  public subscript(bounds: Range<Index>) -> SubSequence {
    return SubSequence(
      base: base[
        (bounds.lowerBound.position?.earlierElement ?? base.endIndex)
        ..<
        (bounds.upperBound.position?.laterElement ?? base.endIndex)
      ]
    )
  }
  
  @inlinable
  public subscript(position: Index) -> Element {
    get {
      guard let position = position.position else {
        fatalAttemptToSubscriptEndIndex(position)
      }
      return Element(
        earlierElement: base[position.earlierElement],
        laterElement: base[position.laterElement]
      )
    }
  }
  
  @inlinable
  public func distance(
    from start: AdjacentPairCollectionIndex<Base.Index>,
    to end: AdjacentPairCollectionIndex<Base.Index>
  ) -> Int {
    switch (start.position, end.position) {
    case (.some(let lPosition), .some(let rPosition)):
      return base.distance(
        from: lPosition.earlierElement,
        to: rPosition.earlierElement
      )
    case (.some(let lPosition), .none):
      return base.distance(
        from: lPosition.laterElement,
        to: base.endIndex
      )
    case (.none, .some(let rPosition)):
      return base.distance(
        from: base.endIndex,
        to: rPosition.laterElement
      )
    case (.none, .none):
      return 0
    }
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    guard let position = i.position else {
      fatalAttemptToAdvanceEndIndex(i)
    }
    let nextLaterIndex = base.index(after: position.laterElement)
    switch nextLaterIndex == base.endIndex {
    case true:
      return .endIndex
    case false:
      return Index(
        earlierIndex: position.laterElement,
        laterIndex: nextLaterIndex
      )
    }
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int
  ) -> Index {
    switch i.position {
    case .some(let position):
      let earlierIndexDestination = base.index(
        position.earlierElement,
        offsetBy: distance
      )
      let laterIndexDestination = base.index(after: earlierIndexDestination)
      guard laterIndexDestination < base.endIndex else {
        return .endIndex
      }
      return Index(
        earlierIndex: earlierIndexDestination,
        laterIndex: laterIndexDestination
      )
    case .none:
      precondition(distance <= 0)
      guard distance < 0 else {
        return i
      }
      let earlierIndexDestination = base.index(
        base.endIndex,
        offsetBy: (distance - 1)
      )
      let laterIndexDestination = base.index(
        after: earlierIndexDestination
      )
      return Index(
        earlierIndex: earlierIndexDestination,
        laterIndex: laterIndexDestination
      )
    }
  }
}

extension AdjacentPairSequence: BidirectionalCollection where Base: BidirectionalCollection {
  @inlinable
  public func index(before i: Index) -> Index {
    switch i.position {
    case .some(let position):
      return Index(
        earlierIndex: base.index(
          before: position.earlierElement
        ),
        laterIndex: position.earlierElement
      )
    case .none:
      let laterIndex = base.index(before: base.endIndex)
      let earlierIndex = base.index(before: laterIndex)
      return Index(
        earlierIndex: laterIndex,
        laterIndex: earlierIndex
      )
    }
  }
}

extension AdjacentPairSequence: RandomAccessCollection where Base: RandomAccessCollection { }
