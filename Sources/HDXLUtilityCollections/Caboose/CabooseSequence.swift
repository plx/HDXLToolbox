import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

// ------------------------------------------------------------------------- //
// MARK: Sequence + Caboose
// ------------------------------------------------------------------------- //

extension Sequence {

  /// Returns a sequence like `self`, except with `caboose` provided as the last element.
  @inlinable
  public func with(caboose: Element) -> some Sequence<Element> {
    CabooseSequence<Element, Self>(
      base: self,
      caboose: caboose
    )
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: CabooseSequence
// ------------------------------------------------------------------------- //

/// Shorthand for a ``CabooseCollection`` that's also a `Collection` (e.g. b/c it's wrapping some underlying `Collection`).
public typealias CabooseCollection<Element, Base> = CabooseSequence<Element, Base> where Base: Collection<Element>

/// Shorthand for a ``CabooseCollection`` that's also a `BidirectionalCollection` (e.g. b/c it's wrapping some underlying `BidirectionalCollection`).
public typealias CabooseBidirectionalCollection<Element, Base> = CabooseSequence<Element, Base> where Base: BidirectionalCollection<Element>

/// Shorthand for a ``CabooseCollection`` that's also a `RandomAccessCollection` (e.g. b/c it's wrapping some underlying `RandomAccessCollection`).
public typealias CabooseRandomAccessCollection<Element, Base> = CabooseSequence<Element, Base> where Base: RandomAccessCollection<Element>

/// ``CabooseSequence`` adapts an underlying base sequence by attaching an additional element at the end of the sequence.
///
/// In other words, it performs the following adaption:
///
/// - original: `[engineCar, diningCar, passengerCar]`
/// - caboose: `caboose`
/// - adapted: `[engineCar, diningCar, passengerCar, caboose]`
///
/// ...but without modifying the underlying sequence *or*, say, copying the original + the caboose into some newly-allocated array.
///
/// - Note: a caboose collection will *never* be empty.
/// - Note: a caboose collection will inherit the "collectionality" of the underlying sequence (e.g. it's a collection iff `Base` is a collection, etc.).
///
/// - seealso: ``AffixSequence``
/// - seealso: ``CabooseCollection``
/// - seealso: ``CabooseBidirectionalCollection``
/// - seealso: ``CabooseRandomAccessCollection``
///
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyCodable
@ConstructorDebugDescription
public struct CabooseSequence<Element, Base>
where
Base: Sequence<Element>
{
  
  @usableFromInline
  internal var base: Base
  
  @usableFromInline
  internal var caboose: Element
  
  @inlinable
  @PreferredMemberwiseInitializer
  internal init(base: Base, caboose: Element) {
    self.base = base
    self.caboose = caboose
  }
  
}

extension CabooseSequence: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "caboose \(String(describing: caboose)) attached-to \(String(describing: base))"
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Sequence
// ------------------------------------------------------------------------- //

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

// ------------------------------------------------------------------------- //
// MARK: - Collection
// ------------------------------------------------------------------------- //

extension CabooseSequence:
  Collection,
  InternalPositionCollection,
  LinearizableInternalPositionCollection
where
Base: Collection
{
  
  @usableFromInline
  package typealias InternalPosition = CabooseCollectionPosition<Base.Index>
  
  public typealias Index = CabooseCollectionIndex<Base.Index>
  
  // MARK: - Collection API

  @inlinable
  public var isEmpty: Bool { false }
  
  @inlinable
  public var count: Int {
    base.count + 1
  }
  
  // MARK: - InternalPositionCollection API
  
  @inlinable
  package var firstInternalPosition: InternalPosition? {
    switch base.firstSubscriptableIndex {
    case .some(let subcriptableBaseIndex):
      return .base(subcriptableBaseIndex)
    case .none:
      return .caboose
    }
  }
  
  @inlinable
  package var lastInternalPosition: InternalPosition? {
    .caboose
  }
  
  @inlinable
  package subscript(position: InternalPosition) -> Element {
    switch position {
    case .base(let baseIndex):
      precondition(baseIndex < base.endIndex)
      return base[baseIndex]
    case .caboose:
      return caboose
    }
  }
  
  @inlinable
  package func internalPosition(
    after position: InternalPosition
  ) -> InternalPosition? {
    switch position {
    case .base(let baseIndex):
      precondition(baseIndex < base.endIndex)
      let nextIndex = base.index(after: baseIndex)
      switch nextIndex < base.endIndex {
      case true:
        return .base(nextIndex)
      case false:
        return .caboose
      }
    case .caboose:
      preconditionFailure("Attempted to subscript the endIndex.")
    }
  }
  
  // MARK: - LinearizableInternalPositionCollection API

  @inlinable
  package func linearPosition(forInternalPosition internalPosition: InternalPosition) -> Int {
    switch internalPosition {
    case .base(let baseIndex):
      precondition(baseIndex < base.endIndex)
      return base.distanceFromStart(to: baseIndex)
    case .caboose:
      return base.count
    }
  }
  
  @inlinable
  package func internalPosition(forLinearPosition linearPosition: Int) -> InternalPosition? {
    switch linearPosition <=> base.count {
    case .orderedAscending:
      return .base(base.index(offsetFromStartBy: linearPosition))
    case .orderedSame:
      return .caboose
    case .orderedDescending:
      return nil
    }
  }

}

// ------------------------------------------------------------------------- //
// MARK: - BidirectionalCollection
// ------------------------------------------------------------------------- //

extension CabooseSequence:
  BidirectionalCollection,
  InternalPositionBidirectionalCollection
where
Base: BidirectionalCollection
{
  
  @inlinable
  package func internalPosition(
    before position: InternalPosition
  ) -> InternalPosition? {
    switch position {
    case .base(let baseIndex):
      guard baseIndex > base.startIndex else {
        preconditionFailure("Attempted to go back from the start position.")
      }
      
      return .base(base.index(before: baseIndex))
    case .caboose:
      guard let finalSubscriptableBaseIndex = base.finalSubscriptableIndex else {
        preconditionFailure("Attempted to go back from the start position.")
      }
      
      return .base(finalSubscriptableBaseIndex)
    }
  }

}

// ------------------------------------------------------------------------- //
// MARK: - RandomAccessCollection
// ------------------------------------------------------------------------- //

extension CabooseSequence:
  RandomAccessCollection,
  InternalPositionRandomAccessCollection
where 
Base: RandomAccessCollection { }

// ------------------------------------------------------------------------- //
// MARK: - MutableCollection
// ------------------------------------------------------------------------- //

extension CabooseSequence:
  MutableCollection,
  InternalPositionMutableCollection
where
Base: MutableCollection 
{
  
  @inlinable
  package subscript(position: InternalPosition) -> Element {
    get {
      switch position {
      case .base(let baseIndex):
        precondition(baseIndex < base.endIndex)
        return base[baseIndex]
      case .caboose:
        return caboose
      }
    }
    set {
      switch position {
      case .base(let baseIndex):
        precondition(baseIndex < base.endIndex)
        base[baseIndex] = newValue
      case .caboose:
        caboose = newValue
      }
    }
  }
  
}
