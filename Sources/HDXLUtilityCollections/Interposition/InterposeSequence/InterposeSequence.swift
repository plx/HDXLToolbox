import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

// ------------------------------------------------------------------------- //
// MARK: InterposeSequence - Definition
// ------------------------------------------------------------------------- //

extension Sequence {
  @inlinable
  public var interpositions: some Sequence<InterposeSequenceElement<Element>> {
    InterposeSequence(base: self)
  }
}

// ------------------------------------------------------------------------- //
// MARK: InterposeSequence - Definition
// ------------------------------------------------------------------------- //

/// Convenience when you need to require ``InterposeSequence`` to conform to ``Collection``.
public typealias InterposeCollection<Base> = InterposeSequence<Base> where Base: Collection

/// Convenience when you need to require ``InterposeSequence`` to conform to ``BidirectionalCollection``.
public typealias InterposeBidirectionalCollection<Base> = InterposeSequence<Base> where Base: BidirectionalCollection

/// Convenience when you need to require ``InterposeSequence`` to conform to ``RandomAccessCollection``.
public typealias InterposeRandomAccessCollection<Base> = InterposeSequence<Base> where Base: RandomAccessCollection

// ------------------------------------------------------------------------- //
// MARK: InterposeSequence - Definition
// ------------------------------------------------------------------------- //

/// What I call the "interpose sequence" is derived-from a "base sequence" by inserting interposition-elements
/// between the original elements:
///
/// - `original`: `[a, b, c]`
/// - `original.interpositions`: `[a, interpose(a,b), b, interpose(b, c), c]`
///
/// The *motivation* for these interpose sequence is to use them as building-blocks for higher-level
/// UI components. For example, to create a list-with-separators one can start from a base list of elements,
/// prepare the corresponding interposition-sequence, and then—eventually—apply the following transformation:
///
/// - elements => cells (or other content items)
/// - interpositions => separators (or other in-between items associated-with but distinct-from the basal elements)
///
/// For maximum flexibility this type has been defined atop ``Sequence``, but it contains conditional conformances
/// for the various flavors of immutable collections (e.g. ``Collection``, ``BidirectionalCollection``,
/// and ``RandomAccessCollection``).
///
/// - Note: an ``InterposeSequence`` will only include interpositions between *elements*—it **never** inserts them *before* the *first element* or *after* the *final element*.
///
/// - seealso: ``InterposeCollection`` (shorthand for when you need/require a conformance to ``Collection``)
/// - seealso: ``InterposeBidirectionalCollection`` (shorthand for when you need/require a conformance to ``BidirectionalCollection``)
/// - seealso: ``InterposeRandomAccessCollection`` (shorthand for when you need/require a conformance to ``RandomAccessCollection``)
/// - seealso: ``EndcapInterposeSequence`` for a similar sequence that includes (arbitrary) "endcaps" (e.g. intro/outro elements)
/// - seealso: ``Sequence.interpositions`` for the public-facing way to get an interposition
/// - seealso: ``InterpositionElement`` for the type used to (directly) represent interpositions in-and-of-themselves
/// - seealso: ``InterposeSequenceIterator`` for the sequence's iterator type.
/// - seealso: ``InterposeSequenceIndex`` for the index used when this picks
///
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyAutoIdentifiable
public struct InterposeSequence<Base>: Sequence where Base: Sequence {
  public typealias Iterator = InterposeSequenceIterator<Base.Iterator>
  public typealias BaseElement = Base.Element
  public typealias Interposition = InterpositionElement<BaseElement>

  @usableFromInline
  internal let base: Base
  
  @inlinable
  internal init(base: Base) {
    self.base = base
  }
  
  @inlinable
  public var underestimatedCount: Int {
    base.underestimatedCount.impliedInterposeElementCount
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(baseIterator: base.makeIterator())
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension InterposeSequence: CustomStringConvertible {
  @inlinable
  public var description: String {
    "interpose-sequence for \(String(describing: base))"
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension InterposeSequence: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    "InterposeSequence<\(String(reflecting: Base.self))>(base: \(String(reflecting: base)))"
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Collection
// ------------------------------------------------------------------------- //

extension InterposeSequence: 
  Collection,
  InternalPositionCollection,
  LinearizableInternalPositionCollection
where Base: Collection
{
  @usableFromInline
  package typealias InternalPosition = InterposeCollectionPosition<Base.Index>
  public typealias Index = InterposeCollectionIndex<Base.Index>
  
  // MARK: - Collection API
  
  @inlinable
  public var isEmpty: Bool {
    base.isEmpty
  }
  
  @inlinable
  public var count: Int {
    base.count.impliedInterposeElementCount
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
    case .some(let subscriptableBaseIndex):
      .element(subscriptableBaseIndex)
    case .none:
      nil
    }
  }
  
  @inlinable
  package subscript(position: InternalPosition) -> Element {
    switch position {
    case .element(let baseIndex):
      precondition(baseIndex < base.endIndex)
      return .element(base[baseIndex])
    case .interposition(let interposition):
      return .interposition(
        Interposition(
          precedingElement: base[interposition.precedingElement],
          subsequentElement: base[interposition.subsequentElement]
        )
      )
    }
  }
  
  @inlinable
  package func internalPosition(
    after position: InternalPosition
  ) -> InternalPosition? {
    switch position {
    case .element(let baseIndex):
      precondition(baseIndex < base.endIndex)
      let nextIndex = base.index(after: baseIndex)
      switch nextIndex < base.endIndex {
      case true:
        return .interposition(
          InternalPosition.Interposition(
            precedingElement: baseIndex,
            subsequentElement: nextIndex
          )
        )
      case false:
        return nil
      }
    case .interposition(let interposition):
      precondition(interposition.subsequentElement < base.endIndex)
      return .element(interposition.subsequentElement)
    }
  }
  
  // MARK: - LinearizableInternalPositionCollection API
  
  @inlinable
  package func linearPosition(forInternalPosition internalPosition: InternalPosition) -> Int {
    switch internalPosition {
    case .element(let baseIndex):
      precondition(baseIndex < base.endIndex)
      return 2 * base.distanceFromStart(to: baseIndex)
    case .interposition(let interposition):
      return 1 + 2 * base.distanceFromStart(to: interposition.precedingElement)
    }
  }
  
  @inlinable
  package func internalPosition(forLinearPosition linearPosition: Int) -> InternalPosition? {
    guard (0...(base.count * 2)).contains(linearPosition) else {
      return nil
    }

    let (baseDistance, remainder) = linearPosition.quotientAndRemainder(dividingBy: 2)
    let baseIndex = base.index(offsetFromStartBy: baseDistance)
    precondition(baseIndex < base.endIndex)
    switch remainder == 0 {
    case true:
      return .element(baseIndex)
    case false:
      let nextBaseIndex = base.index(after: baseIndex)
      return .interposition(
        InternalPosition.Interposition(
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

extension InterposeSequence: 
  BidirectionalCollection,
  InternalPositionBidirectionalCollection
where Base: BidirectionalCollection
{
  
  @inlinable
  package func internalPosition(
    before position: InternalPosition
  ) -> InternalPosition? {
    switch position {
    case .element(let elementIndex):
      guard let previousElementIndex = base.subscriptableIndex(before: elementIndex) else {
        preconditionFailure("Attempted to go back from the start position.")
      }
      
      return .interposition(
        InternalPosition.Interposition(
          precedingElement: previousElementIndex,
          subsequentElement: elementIndex
        )
      )
    case .interposition(let interposition):
      precondition(interposition.precedingElement >= base.startIndex)
      return .element(interposition.precedingElement)
    }
  }
  
}

extension InterposeSequence: 
  RandomAccessCollection,
  InternalPositionRandomAccessCollection
where Base: RandomAccessCollection { }
