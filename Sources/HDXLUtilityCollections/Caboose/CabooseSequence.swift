import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

extension Sequence {
  
  @inlinable
  public func with(caboose: Element) -> some Sequence<Element> {
    CabooseSequence<Element, Self>(
      base: self,
      caboose: caboose
    )
  }
  
}

public typealias CabooseCollection<Element, Base> = CabooseSequence<Element, Base> where Base: Collection<Element>

@frozen
public struct CabooseSequence<Element, Base> where Base: Sequence<Element> {
  
  @usableFromInline
  internal var base: Base
  
  @usableFromInline
  internal var caboose: Element
  
  @inlinable
  internal init(base: Base, caboose: Element) {
    self.base = base
    self.caboose = caboose
  }
  
}

extension CabooseSequence: Sendable where Base: Sendable, Element: Sendable  { }
extension CabooseSequence: Equatable where Base: Equatable, Element: Equatable { }
extension CabooseSequence: Hashable where Base: Hashable, Element: Hashable { }
extension CabooseSequence: Codable where Base: Codable, Element: Codable { }

extension CabooseSequence: Identifiable where Base: Hashable, Element: Hashable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

extension CabooseSequence: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "caboose \(String(describing: caboose)) attached-to \(String(describing: base))"
  }
  
}

extension CabooseSequence: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      arguments: (
        ("base", base),
        ("caboose", caboose)
      )
    )
  }
  
}

extension CabooseSequence: Sequence {
  
  public typealias Iterator = CabooseSequenceIterator<Element, Base.Iterator>
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(
      base: base.makeIterator(),
      caboose: caboose
    )
  }
  
  @inlinable
  public var underestimatedCount: Int {
    base.underestimatedCount + 1
  }
  
}

extension CabooseSequence: Collection where Base: Collection {
  
  @usableFromInline
  internal typealias BaseIndex = Base.Index
  
  @usableFromInline
  internal typealias Position = CabooseCollectionPosition<BaseIndex>
  
  public typealias Index = CabooseCollectionIndex<Base.Index>
  
  @inlinable
  public var isEmpty: Bool { false }
  
  @inlinable
  public var count: Int {
    base.count + 1
  }
  
  @inlinable
  public var startIndex: Index {
    switch base.firstSubscriptableIndex {
    case .some(let baseIndex):
      return Index(baseIndex: baseIndex)
    case .none:
      return endIndex
    }
  }
  
  @inlinable
  public var endIndex: Index {
    Index.endIndex
  }
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index
  ) -> Int {
    switch (start.position, end.position) {
    case (.some(let startPosition), .some(let endPosition)):
      switch (startPosition, endPosition) {
      case (.base(let startBaseIndex), .base(let endBaseIndex)):
        precondition(startBaseIndex != base.endIndex)
        precondition(endBaseIndex != base.endIndex)
        return base.distance(
          from: startBaseIndex,
          to: endBaseIndex
        )
      case (.base(let startBaseIndex), .caboose):
        precondition(startBaseIndex != base.endIndex)
        return 1 + base.distance(from: startBaseIndex, to: base.endIndex)
      case (.caboose, .base(let endBaseIndex)):
        precondition(endBaseIndex != base.endIndex)
        return base.distance(from: base.endIndex, to: endBaseIndex) - 1
      case (.caboose, .caboose):
        return 0
      }
    case (.some(let startPosition), .none):
      switch startPosition {
      case .base(let startBaseIndex):
        precondition(startBaseIndex != base.endIndex)
        return 2 + base.distance(from: startBaseIndex, to: base.endIndex)
      case .caboose:
        return 1
      }
    case (.none, .some(let endPosition)):
      switch endPosition {
      case .base(let endBaseIndex):
        precondition(endBaseIndex != base.endIndex)
        return base.distance(from: base.endIndex, to: endBaseIndex) - 2
      case .caboose:
        return -1
      }
    case (.none, .none):
      return 0
    }
  }
  
  @inlinable
  public subscript(position: Index) -> Element {
    guard let position = position.position else {
      fatalAttemptToSubscriptEndIndex(position)
    }
    switch position {
    case .base(let baseIndex):
      precondition(baseIndex != base.endIndex)
      return base[baseIndex]
    case .caboose:
      return caboose
    }
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    guard let position = i.position else {
      fatalAttemptToAdvanceEndIndex(i)
    }
    switch position {
    case .base(let baseIndex):
      precondition(baseIndex != base.endIndex)
      switch base.subscriptableIndex(after: baseIndex) {
      case .some(let nextBaseIndex):
        return Index(baseIndex: nextBaseIndex)
      case .none:
        return Index.caboose
      }
    case .caboose:
      return Index.endIndex
    }
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int
  ) -> Index {
    guard distance != 0 else { return i }
    switch i.position {
    case .none:
      if distance == -1 {
        return .caboose
      } else if distance <= -2 {
        return Index(
          baseIndex: base.index(
            base.endIndex,
            offsetBy: distance + 2
          )
        )
      } else {
        fatalIndexNavigationMistake(i, offsetBy: distance)
      }
    case .some(.base(let baseIndex)):
      precondition(baseIndex != base.endIndex)
      switch distance > 0 {
      case true:
        guard let finalBaseIndex = base.finalSubscriptableIndex else {
          fatalIndexNavigationMistake(i, offsetBy: distance)
        }
        switch base.index(baseIndex, offsetBy: distance, limitedBy: finalBaseIndex) {
        case .some(let destinationBaseIndex):
          return Index(baseIndex: destinationBaseIndex)
        case .none:
          let distanceToEndOfBase = base.distance(from: baseIndex, to: base.endIndex)
          if distanceToEndOfBase == distance {
            return .caboose
          } else if distanceToEndOfBase + 1 == distance {
            return .endIndex
          } else {
            fatalIndexNavigationMistake(i, offsetBy: distance)
          }
        }
      case false:
        assert(distance < 0) // *should* be true b/c of initial guard on `distance != 0`
        return Index(
          baseIndex: base.index(
            baseIndex,
            offsetBy: distance
          )
        )
      }
    case .some(.caboose):
      if distance > 1 {
        fatalIndexNavigationMistake(i, offsetBy: distance)
      } else if distance == 1 {
        return .endIndex
      } else if let finalBaseIndex = base.finalSubscriptableIndex {
        assert(distance < 0)
        let adjustedDistance = distance + 1
        assert(adjustedDistance <= 0)
        return Index(
          baseIndex: base.index(
            finalBaseIndex,
            offsetBy: adjustedDistance
          )
        )
      } else {
        fatalIndexNavigationMistake(i, offsetBy: distance)
      }
    }
  }
  
}

extension CabooseSequence: BidirectionalCollection where Base: BidirectionalCollection {
  
  @inlinable
  public func index(before i: Index) -> Index {
    switch i.position {
    case .none:
      return .caboose
    case .some(.caboose):
      guard let finalBaseIndex = base.finalSubscriptableIndex else {
        fatalAttemptToGoBackFromStartIndex(i)
      }
      return Index(baseIndex: finalBaseIndex)
    case .some(.base(let baseIndex)):
      precondition(baseIndex != base.endIndex)
      return Index(
        baseIndex: base.index(
          before: baseIndex
        )
      )
    }
  }
  
}

extension CabooseSequence: RandomAccessCollection where Base: RandomAccessCollection { }

extension CabooseSequence: MutableCollection where Base: MutableCollection {
  
  @inlinable
  public subscript(position: Index) -> Element {
    get {
      guard let position = position.position else {
        fatalAttemptToSubscriptEndIndex(position)
      }
      switch position {
      case .base(let baseIndex):
        precondition(baseIndex != base.endIndex)
        return base[baseIndex]
      case .caboose:
        return caboose
      }
    }
    set {
      guard let position = position.position else {
        fatalAttemptToSubscriptEndIndex(position)
      }
      switch position {
      case .base(let baseIndex):
        precondition(baseIndex != base.endIndex)
        base[baseIndex] = newValue
      case .caboose:
        caboose = newValue
      }
    }
  }
  
}
