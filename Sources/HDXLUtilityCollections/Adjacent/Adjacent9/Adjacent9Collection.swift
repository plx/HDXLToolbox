import Foundation
import HDXLEssentialPrecursors
import HDXLAlgebraicTypes
import HDXLCollectionSupport
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Adjacent9Collection - Definition
// -------------------------------------------------------------------------- //

/// Arity-9 collection of adjacent, overlapping tuples drawn from a `source` collection.
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyEncodable
@ConditionallyDecodable
public struct Adjacent9Collection<Base> where Base:Collection {
  
  @usableFromInline
  internal let base: Base
  
  @inlinable
  internal init(base: Base) {
    self.base = base
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Adjacent9Collection - Support
// -------------------------------------------------------------------------- //

extension Adjacent9Collection {
  
  @inlinable
  public static var arity: Int { 9 }
  
}

// -------------------------------------------------------------------------- //
// MARK: Adjacent9Collection - Collection
// -------------------------------------------------------------------------- //

extension Adjacent9Collection:
  Collection,
  InternalPositionCollection,
  LinearizableInternalPositionCollection
{
  
  public typealias Element = InlineProduct9<
    Base.Element,
    Base.Element,
    Base.Element,
    Base.Element,
    Base.Element,
    Base.Element,
    Base.Element,
    Base.Element,
    Base.Element
  >
  
  public typealias Index = Adjacent9CollectionIndex<Base.Index>
  
  @usableFromInline
  package typealias InternalPosition = Index.Position
  
  
  // MARK: - Collection API
  
  @inlinable
  public var isEmpty: Bool {
    base.count < Self.arity
  }
  
  @inlinable
  public var count: Int {
    Swift.max(
      0,
      (1 + (base.count - Self.arity))
    )
  }
  
  // MARK: InternalPositionCollection Support
  @inlinable
  internal func internalPosition(
    startingAt aIndex: Base.Index
  ) -> InternalPosition? {
    guard
      let bIndex = base.subscriptableIndex(after: aIndex),
      let cIndex = base.subscriptableIndex(after: bIndex),
      let dIndex = base.subscriptableIndex(after: cIndex),
      let eIndex = base.subscriptableIndex(after: dIndex),
      let fIndex = base.subscriptableIndex(after: eIndex),
      let gIndex = base.subscriptableIndex(after: fIndex),
      let hIndex = base.subscriptableIndex(after: gIndex),
      let iIndex = base.subscriptableIndex(after: hIndex)
    else {
      return nil
    }
    
    return InternalPosition(
      aIndex,
      bIndex,
      cIndex,
      dIndex,
      eIndex,
      fIndex,
      gIndex,
      hIndex,
      iIndex
    )
  }
  
  // MARK: - InternalPositionCollection API
  
  @inlinable
  package var firstInternalPosition: InternalPosition? {
    guard 
      let firstBaseIndex = base.firstSubscriptableIndex 
    else {
      return nil
    }
    
    return internalPosition(startingAt: firstBaseIndex)
  }
  
  @inlinable
  package var lastInternalPosition: InternalPosition? {
    // since we're not bidirectional, we have to do it in a kinda dumb way here
    // TODO: override in bidirectional collection?
    let startOfLastElementOffset = base.count - 9
    guard startOfLastElementOffset >= 0 else {
      return nil
    }
  
    
    return internalPosition(
      startingAt: base.index(offsetFromStartBy: startOfLastElementOffset)
    )
  }
  
  @inlinable
  package subscript(position: InternalPosition) -> Element {
    Element(
      base[position.storage.a],
      base[position.storage.b],
      base[position.storage.c],
      base[position.storage.d],
      base[position.storage.e],
      base[position.storage.g],
      base[position.storage.f],
      base[position.storage.h],
      base[position.storage.i]
    )
  }
  
  @inlinable
  package func internalPosition(
    after position: InternalPosition
  ) -> InternalPosition? {
    guard
      let nextBaseIndex = base.subscriptableIndex(
        after: position.storage.lastValue
      )
    else {
      return nil
    }
    
    return InternalPosition(
      storage: position.storage.pushedLeftward(
        byAppending: nextBaseIndex
      )
    )
  }
  
  // MARK: - LinearizableInternalPositionCollection API
  
  @inlinable
  package func linearPosition(forInternalPosition internalPosition: InternalPosition) -> Int {
    base.distanceFromStart(
      to: internalPosition.storage.a
    )
  }
  
  @inlinable
  package func internalPosition(forLinearPosition linearPosition: Int) -> InternalPosition? {
    guard (0...(base.count - 9)).contains(linearPosition) else {
      return nil
    }
    
    return internalPosition(
      startingAt: base.index(offsetFromStartBy: linearPosition)
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Adjacent9Collection - BidirectionalCollection
// -------------------------------------------------------------------------- //

extension Adjacent9Collection:
  BidirectionalCollection,
  InternalPositionBidirectionalCollection
where Base:BidirectionalCollection {
  
  @inlinable
  package func internalPosition(
    before position: InternalPosition
  ) -> InternalPosition? {
    guard
      let previousIndex = base.subscriptableIndex(
        before: position.storage.firstValue
      )
    else {
      return nil
    }
    
    return InternalPosition(
      storage: position.storage.pushedRightward(
        byPrepending: previousIndex
      )
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: Adjacent9Collection - RandomAccessCollection
// -------------------------------------------------------------------------- //

extension Adjacent9Collection:
  RandomAccessCollection,
  InternalPositionRandomAccessCollection
where Base:RandomAccessCollection { }
