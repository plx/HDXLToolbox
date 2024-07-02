import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

// ------------------------------------------------------------------------- //
// MARK: Sequence + Affixes
// ------------------------------------------------------------------------- //

extension Sequence {
  
  /// Provides a sequence adapted to provide the `prefixElement` before the elements from `self` and then the `suffixElement` after the elements from `self`.
  ///
  /// - seealso: ``with(prefixElement:)``
  /// - seealso: ``with(suffixElement:)``
  /// - seealso: ``with(caboose:)``
  @inlinable
  public func with(
    prefixElement: Element,
    suffixElement: Element
  ) -> some Sequence<Element> {
    AffixSequence<Self>(
      prefixElement: prefixElement,
      base: self,
      suffixElement: suffixElement
    )
  }
  
  /// Provides a sequence adapted to provide the `prefixElement` before the elements from `self`.
  ///
  /// - seealso: ``with(suffixElement:)``
  /// - seealso: ``with(prefixElement:suffixElement:)``
  /// - seealso: ``with(caboose:)``
  @inlinable
  public func with(prefixElement: Element) -> some Sequence<Element> {
    AffixSequence<Self>(
      prefixElement: prefixElement,
      base: self,
      suffixElement: nil
    )
  }
  
  /// Provides a sequence adapted to provide the `suffixElement` after the elements from `self`.
  ///
  /// - Note: if you truly only need a single suffix element, consider using `with(caboose:)` instead.
  ///
  /// - seealso: ``with(prefixElement:)``
  /// - seealso: ``with(prefixElement:suffixElement:)``
  /// - seealso: ``with(caboose:)``
  @inlinable
  public func with(suffixElement: Element) -> some Sequence<Element> {
    AffixSequence<Self>(
      prefixElement: nil,
      base: self,
      suffixElement: suffixElement
    )
  }
  
  /// Provides a sequence adapted to provide the `prefixElement` before the elements from `self` and then the `suffixElement` after the elements from `self`.
  ///
  /// - seealso: ``with(prefixElement:)``
  /// - seealso: ``with(suffixElement:)``
  /// - seealso: ``with(caboose:)``
  @inlinable
  public func with(
    possiblePrefixElement: Element?,
    possibleSuffixElement: Element?
  ) -> some Sequence<Element> {
    AffixSequence<Self>(
      prefixElement: possiblePrefixElement,
      base: self,
      suffixElement: possibleSuffixElement
    )
  }
  
  /// Provides a sequence adapted to provide the `prefixElement` before the elements from `self`.
  ///
  /// - seealso: ``with(suffixElement:)``
  /// - seealso: ``with(prefixElement:suffixElement:)``
  /// - seealso: ``with(caboose:)``
  @inlinable
  public func with(possiblePrefixElement: Element?) -> some Sequence<Element> {
    AffixSequence<Self>(
      prefixElement: possiblePrefixElement,
      base: self,
      suffixElement: nil
    )
  }
  
  /// Provides a sequence adapted to provide the `suffixElement` after the elements from `self`.
  ///
  /// - Note: if you truly only need a single suffix element, consider using `with(caboose:)` instead.
  ///
  /// - seealso: ``with(prefixElement:)``
  /// - seealso: ``with(prefixElement:suffixElement:)``
  /// - seealso: ``with(caboose:)``
  @inlinable
  public func with(possibleSuffixElement: Element?) -> some Sequence<Element> {
    AffixSequence<Self>(
      prefixElement: nil,
      base: self,
      suffixElement: possibleSuffixElement
    )
  }
}

// ------------------------------------------------------------------------- //
// MARK: Synonyms
// ------------------------------------------------------------------------- //

/// Shorthand for an ``AffixSequence`` that's also a `Collection` (e.g. b/c it's wrapping some underlying `Collection`).
public typealias AffixCollection<Base> = AffixSequence<Base> where Base: Collection

/// Shorthand for an ``AffixSequence`` that's also a `BidirectionalCollection` (e.g. b/c it's wrapping some underlying `BidirectionalCollection`).
public typealias AffixBidirectionalCollection<Base> = AffixSequence<Base> where Base: BidirectionalCollection

/// Shorthand for an ``AffixSequence`` that's also a `RandomAccessCollection` (e.g. b/c it's wrapping some underlying `RandomAccessCollection`).
public typealias AffixRandomAccessCollection<Base> = AffixSequence<Base> where Base: RandomAccessCollection

// ------------------------------------------------------------------------- //
// MARK: AffixSequence
// ------------------------------------------------------------------------- //

/// ``AffixSequence`` adapts its underlying base sequence to (possibly) have any combination of:
///
/// - a possible ``prefixElement`` preceding the elements from ``base``
/// - a possible ``suffixElement`` following the elements from ``base``
///
/// In other words, you go from this:
///
/// - `original`: `[foo, bar, baz]`
/// - `adapted`: `[prefix, foo, bar, baz]`
///
/// ...to except without either *modifying* the underlying sequence *or* allocating new storage and copying things into it.
///
/// - note:
///
/// This is deliberately *not* a `MutableCollection` due to the awkwardness of maintaining the invariants.
///
/// More-precisely, the affixes are of type `Element?` but the affix-sequence remains exposed as a sequence of `Element`.
/// Pulling this off is easy for an *immutable* implementation--all we need to do is *never* vend indices corresponding to nil affixes.
///
/// In theory we could still expose mutability (w/ non-nil `Element` values)  b/c, in theory, users should never get indices
/// that don't correspond to non-negative affixes. In practice, the risk feels high and the need feels low--happy to revisit in the future.
///
/// - seealso: ``CabooseSequence``
/// - seealso: ``AffixCollection``
/// - seealso: ``AffixBidirectionalCollection``
/// - seealso: ``AffixRandomAccessCollection``
///
@frozen
@ConstructorDebugDescription
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
  @PreferredMemberwiseInitializer
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

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension AffixSequence: Sendable where Base: Sendable, Base.Element: Sendable { }
extension AffixSequence: Equatable where Base: Equatable, Base.Element: Equatable { }
extension AffixSequence: Hashable where Base: Hashable, Base.Element: Hashable { }
extension AffixSequence: Encodable where Base: Encodable, Base.Element: Encodable { }
extension AffixSequence: Decodable where Base: Decodable, Base.Element: Decodable { }

extension AffixSequence: Identifiable, AutoIdentifiable where Base: Hashable, Base.Element: Hashable { }

// ------------------------------------------------------------------------- //
// MARK: - Custom String Convertible
// ------------------------------------------------------------------------- //

extension AffixSequence: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "\(String(describing: base)) in-between (\(String(describing: prefixElement)), \(String(describing: suffixElement)))"
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Collection
// ------------------------------------------------------------------------- //

extension AffixSequence:
  Collection,
  InternalPositionCollection,
  LinearizableInternalPositionCollection
where 
Base: Collection
{
  public typealias Index = AffixCollectionIndex<Base.Index>
  
  @usableFromInline
  package typealias InternalPosition = AffixCollectionPosition<Base.Index>
  
  @inlinable
  public var isEmpty: Bool {
    allAreTrue(
      prefixElement == nil,
      suffixElement == nil,
      base.isEmpty
    )
  }
  
  @inlinable
  public var count: Int {
    prefixElementCount + baseElementCount + suffixElementCount
  }
  
  @inlinable
  package var hasPrefixElement: Bool { prefixElement != nil }

  @inlinable
  package var hasSuffixElement: Bool { suffixElement != nil }
  
  @inlinable
  package var hasBaseElements: Bool { !base.isEmpty }

  @inlinable
  package var prefixElementCount: Int { hasPrefixElement.oneIfTrue }
  
  @inlinable
  package var suffixElementCount: Int { hasSuffixElement.oneIfTrue }
  
  @inlinable
  package var baseElementCount: Int { base.count }

  @inlinable
  package var prefixLinearPosition: Int? {
    switch hasPrefixElement {
    case true:
      0
    case false:
      nil
    }
  }

  @inlinable
  package var baseLinearPositionRange: ClosedRange<Int>? {
    let baseElementCount = baseElementCount
    guard baseElementCount > 0 else {
      return nil
    }
    
    switch hasPrefixElement {
    case true:
      return 1...baseElementCount
    case false:
      return 0...(baseElementCount - 1)
    }
  }

  @inlinable
  package var suffixLinearPosition: Int? {
    guard hasSuffixElement else {
      return nil
    }
    
    return prefixElementCount + baseElementCount
  }

  @inlinable
  package var firstInternalPosition: InternalPosition? {
    if hasPrefixElement {
      .prefix
    } else if let firstBaseElementIndex = base.firstSubscriptableIndex {
      .base(firstBaseElementIndex)
    } else if hasSuffixElement {
      .suffix
    } else {
      nil
    }
  }
  
  @inlinable
  package var lastInternalPosition: InternalPosition? {
    if hasSuffixElement {
      .suffix
    } else if let lastBaseElementIndex = base.finalSubscriptableIndex {
      .base(lastBaseElementIndex)
    } else if hasPrefixElement {
      .prefix
    } else {
      nil
    }
  }

  @inlinable
  package subscript(internalPosition: InternalPosition) -> Element {
    switch internalPosition {
    case .prefix:
      guard let prefixElement else {
        preconditionFailure(
          """
          Attempted to subscript the non-existant `.prefix` position on \(String(reflecting: self))!
          """
        )
      }
      
      return prefixElement
    case .base(let baseIndex):
      precondition(baseIndex < base.endIndex)
      return base[baseIndex]
    case .suffix:
      guard let suffixElement else {
        preconditionFailure(
          """
          Attempted to subscript the non-existant `.suffix` position on \(String(reflecting: self))!
          """
        )
      }
      
      return suffixElement
    }
  }
  
  @inlinable
  package func internalPosition(
    after position: InternalPosition
  ) -> InternalPosition? {
    switch position {
    case .prefix:
      if let firstBaseIndex = base.firstSubscriptableIndex {
        return .base(firstBaseIndex)
      } else if hasSuffixElement {
        return .suffix
      } else {
        return nil
      }
    case .base(let baseIndex):
      precondition(baseIndex < base.endIndex)
      if let nextBaseIndex = base.subscriptableIndex(after: baseIndex) {
        return .base(nextBaseIndex)
      } else if hasSuffixElement {
        return .suffix
      } else {
        return nil
      }
    case .suffix:
      return nil
    }
  }
  
  // MARK: - LinearizableInternalPositionCollection API
  
  @inlinable
  package func linearPosition(forInternalPosition internalPosition: InternalPosition) -> Int {
    switch internalPosition {
    case .prefix:
      precondition(hasPrefixElement)
      return 0
    case .base(let baseIndex):
      precondition(baseIndex < base.endIndex)
      return prefixElementCount + base.distanceFromStart(to: baseIndex)
    case .suffix:
      precondition(hasSuffixElement)
      return prefixElementCount + baseElementCount
    }
  }
  
  @inlinable
  package func internalPosition(forLinearPosition linearPosition: Int) -> InternalPosition? {
    if let suffixLinearPosition, suffixLinearPosition == linearPosition {
      .suffix
    } else if let baseLinearPositionRange, baseLinearPositionRange.contains(linearPosition) {
      .base(
        base.index(
          offsetFromStartBy: linearPosition - baseLinearPositionRange.lowerBound
        )
      )
    } else if let prefixLinearPosition, prefixLinearPosition == linearPosition {
      .prefix
    } else {
      nil
    }
  }

}

// ------------------------------------------------------------------------- //
// MARK: - BidirectionalCollection
// ------------------------------------------------------------------------- //

extension AffixSequence:
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
    case .suffix:
      if let finalBaseIndex = base.finalSubscriptableIndex {
        return .base(finalBaseIndex)
      } else if hasPrefixElement {
        return .prefix
      } else {
        return nil
      }
    case .base(let baseIndex):
      precondition(baseIndex > base.startIndex)
      if let previousBaseIndex = base.subscriptableIndex(before: baseIndex) {
        return .base(previousBaseIndex)
      } else if hasPrefixElement {
        return .prefix
      } else {
        return nil
      }
    case .prefix:
      return nil
    }
  }

}

// ------------------------------------------------------------------------- //
// MARK: - RandomAccessCollection
// ------------------------------------------------------------------------- //

extension AffixSequence:
  RandomAccessCollection,
  InternalPositionRandomAccessCollection
where Base: RandomAccessCollection { }
