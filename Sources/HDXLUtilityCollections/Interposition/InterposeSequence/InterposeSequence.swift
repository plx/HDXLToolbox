import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

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
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension InterposeSequence: Sendable where Base: Sendable { }
extension InterposeSequence: Equatable where Base: Equatable { }
extension InterposeSequence: Hashable where Base: Hashable { }
extension InterposeSequence: Encodable where Base: Encodable { }
extension InterposeSequence: Decodable where Base: Decodable { }

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

extension InterposeSequence: Collection where Base: Collection {
  public typealias Index = InterposeCollectionIndex<Base.Index>
  
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
      return .element(
        base[baseIndex]
      )
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
          interposition: Index.Interposition(
            precedingElement: baseIndex,
            subsequentElement: nextBaseIndex
          )
        )
      }
    case .interposition(let baseIndexInderposition):
      return Index(index: baseIndexInderposition.subsequentElement)
    }
  }

}

// ------------------------------------------------------------------------- //
// MARK: - BidirectionalCollection
// ------------------------------------------------------------------------- //

extension InterposeSequence: BidirectionalCollection where Base: BidirectionalCollection {
  
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
        interposition: Index.Interposition(
          precedingElement: base.index(before: baseIndex),
          subsequentElement: baseIndex
        )
      )
    case .some(.interposition(let baseInterposition)):
      return Index(index: baseInterposition.precedingElement)
    }
  }
}

extension InterposeSequence: RandomAccessCollection where Base: RandomAccessCollection { }
