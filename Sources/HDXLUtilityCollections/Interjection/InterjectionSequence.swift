import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

public typealias InterjectionCollection<Base> = InterjectionSequence<Base> where Base: Collection
public typealias InterjectionBidirectionalCollection<Base> = InterjectionSequence<Base> where Base: BidirectionalCollection
public typealias InterjectionRandomAccessCollection<Base> = InterjectionSequence<Base> where Base: RandomAccessCollection

extension Sequence {
  
  @inlinable
  public func with(interjection: Element) -> some Sequence<Element> {
    InterjectionSequence<Self>(
      interjection: interjection,
      base: self
    )
  }
}

// ------------------------------------------------------------------------- //
// MARK: InterjectionSequence
// ------------------------------------------------------------------------- //

/// ``InterjectionSequence`` adapts the underlying ``base`` sequence by inserting an ``interjection``
/// element in-between each adjacent pair from ``base``.
///
/// In other words:
///
/// - `original`: `[mock, ing, bird]`
/// - `adapted`: `[mock, yeah, ing, yeah, bird]`
///
/// ...(yeah, yeah, yeah).
///
@frozen
@ConstructorDebugDescription
public struct InterjectionSequence<Base>: Sequence where Base: Sequence {
  public typealias Element = Base.Element
  public typealias Iterator = InterjectionSequenceIterator<Base.Iterator>
  
  @usableFromInline
  internal let interjection: Element
  
  @usableFromInline
  internal let base: Base
  
  @inlinable
  @PreferredMemberwiseInitializer
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

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Properties
// ------------------------------------------------------------------------- //

extension InterjectionSequence: Sendable where Base: Sendable, Base.Element: Sendable {}
extension InterjectionSequence: Equatable where Base: Equatable, Base.Element: Equatable {}
extension InterjectionSequence: Hashable where Base: Hashable, Base.Element: Hashable {}
extension InterjectionSequence: Encodable where Base: Encodable, Base.Element: Encodable {}
extension InterjectionSequence: Decodable where Base: Decodable, Base.Element: Decodable {}

extension InterjectionSequence: Identifiable, AutoIdentifiable where Base: Hashable, Base.Element: Hashable {}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension InterjectionSequence: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "interjection-of \(String(describing: interjection)) within \(String(describing: base))"
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Collection
// ------------------------------------------------------------------------- //

extension InterjectionSequence: 
  Collection,
  InternalPositionCollection,
  LinearizableInternalPositionCollection
where Base: Collection {
  
  @usableFromInline
  package typealias InternalPosition = InterjectionCollectionPosition<Base.Index>
  
  public typealias Index = InterjectionCollectionIndex<Base.Index>
  
  // MARK: - Collection API
  
  @inlinable
  public var isEmpty: Bool { base.isEmpty }
  
  @inlinable
  public var count: Int {
    base.count + Swift.max(0, base.count - 1)
  }
  
  // MARK: - InternalPositionCollection API
  
  @inlinable
  package var firstInternalPosition: InternalPosition? {
    switch base.firstSubscriptableIndex {
    case .some(let subcriptableBaseIndex):
      .element(subcriptableBaseIndex)
    case .none:
      nil
    }
  }
  
  @inlinable
  package var lastInternalPosition: InternalPosition? {
    switch base.finalSubscriptableIndex {
    case .some(let subcriptableBaseIndex):
      .element(subcriptableBaseIndex)
    case .none:
      nil
    }
  }
  
  @inlinable
  package subscript(position: InternalPosition) -> Element {
    switch position {
    case .element(let baseIndex):
      base[baseIndex]
    case .interjection:
      interjection
    }
  }
  
  @inlinable
  package func internalPosition(
    after position: InternalPosition
  ) -> InternalPosition? {
    switch position {
    case .element(let elementIndex):
      precondition(elementIndex < base.endIndex)
      switch base.subscriptableIndex(after: elementIndex) {
      case .some(let nextSubscriptableIndex):
        return .interjection(
          InternalPosition.Interjection(
            precedingElement: elementIndex,
            subsequentElement: nextSubscriptableIndex
          )
        )
      case .none:
        return nil
      }
    case .interjection(let interjectionIndices):
      precondition(interjectionIndices.subsequentElement < base.endIndex)
      return .element(interjectionIndices.subsequentElement)
    }
  }
  
  // MARK: - LinearizableInternalPositionCollection API
  
  @inlinable
  package func linearPosition(forInternalPosition internalPosition: InternalPosition) -> Int {
    switch internalPosition {
    case .element(let elementIndex):
      precondition(elementIndex < base.endIndex)
      return 2 * base.distanceFromStart(to: elementIndex)
    case .interjection(let interjectionIndices):
      return 1 + 2 * base.distanceFromStart(to: interjectionIndices.precedingElement)
    }
  }
  
  @inlinable
  package func internalPosition(forLinearPosition linearPosition: Int) -> InternalPosition? {
    guard (0..<count).contains(linearPosition) else {
      return nil
    }
    let (baseLinearPosition, remainder) = linearPosition.quotientAndRemainder(dividingBy: 2)
    let baseIndex = base.index(offsetFromStartBy: baseLinearPosition)
    precondition(baseIndex < base.endIndex)
    switch remainder == 0 {
    case true:
      return .element(baseIndex)
    case false:
      let nextBaseIndex = base.index(after: baseIndex)
      precondition(nextBaseIndex < base.endIndex)
      return .interjection(
        InternalPosition.Interjection(
          precedingElement: baseIndex,
          subsequentElement: nextBaseIndex
        )
      )
    }
  }  
}

// ------------------------------------------------------------------------- //
// MARK: - BidirectionalCollection
// ------------------------------------------------------------------------- //

extension InterjectionSequence: 
  BidirectionalCollection,
  InternalPositionBidirectionalCollection
where Base: BidirectionalCollection {
  
  @inlinable
  package func internalPosition(
    before position: InternalPosition
  ) -> InternalPosition? {
    switch position {
    case .element(let elementIndex):
      guard let previousElementIndex = base.subscriptableIndex(before: elementIndex) else {
        preconditionFailure("Attempted to go back from the start position.")
      }
      
      return .interjection(
        InternalPosition.Interjection(
          precedingElement: previousElementIndex,
          subsequentElement: elementIndex
        )
      )
    case .interjection(let interjectionIndices):
      precondition(interjectionIndices.precedingElement >= base.startIndex)
      return .element(interjectionIndices.precedingElement)
    }
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - RandomAccessCollection
// ------------------------------------------------------------------------- //

extension InterjectionSequence: 
  RandomAccessCollection,
  InternalPositionRandomAcccessCollection
where Base: RandomAccessCollection { }
