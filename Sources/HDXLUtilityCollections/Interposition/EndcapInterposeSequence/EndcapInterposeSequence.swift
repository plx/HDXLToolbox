import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequence
// ------------------------------------------------------------------------- //

/// This is like the interpose sequence but with additional "endcap" elements inserted before-and-after
/// the primary sequence.
///
/// In other words:
///
/// - `original`: `[a,b,c]`
/// - `endcap-interpose-sequence`: `[intro, a, interpose(a,b), b, interpose(b,c), c, outro]`
/// 
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyEncodable
@ConditionallyDecodable
@ConstructorDebugDescription
public struct EndcapInterposeSequence<Intro, Outro, Base>: Sequence where Base: Sequence {
  public typealias Iterator = EndcapInterposeSequenceIterator<Intro, Outro, Base.Iterator>
  public typealias BaseElement = Base.Element
  public typealias Interposition = InterpositionElement<BaseElement>
  public typealias Element = EndcapInterposeSequenceElement<Intro,BaseElement,Outro>

  @usableFromInline
  internal let intro: Intro

  @usableFromInline
  internal let outro: Outro

  @usableFromInline
  internal let base: Base
  
  @inlinable
  @PreferredMemberwiseInitializer
  internal init(
    intro: Intro,
    outro: Outro,
    base: Base
  ) {
    self.intro = intro
    self.outro = outro
    self.base = base
  }
  
  @inlinable
  public var underestimatedCount: Int {
    base.underestimatedCount.impliedEndcapInterposeElementCount
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(
      intro: intro,
      outro: outro,
      baseIterator: base.makeIterator()
    )
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequence: CustomStringConvertible {
  @inlinable
  public var description: String {
    "endcap-interpose-sequence for \(String(describing: base))"
  }
}


// ------------------------------------------------------------------------- //
// MARK: - Collection
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequence:
  Collection,
  InternalPositionCollection,
  LinearizableInternalPositionCollection
where Base: Collection {
  
  public typealias Index = EndcapInterposeCollectionIndex<Base.Index>
  
  @usableFromInline
  package typealias InternalPosition = Index.Position
  
  // MARK: Collection API
  
  @inlinable
  public var isEmpty: Bool {
    false
  }
  
  @inlinable
  public var count: Int {
    base.count.impliedEndcapInterposeElementCount
  }
  
  // MARK: - InternalPositionCollection API
  
  @inlinable
  package var firstInternalPosition: InternalPosition? {
    .intro
  }
  
  @inlinable
  package var lastInternalPosition: InternalPosition? {
    .outro
  }
  
  @inlinable
  package subscript(position: InternalPosition) -> Element {
    switch position {
    case .intro:
      return .intro(intro)
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
    case .outro:
      return .outro(outro)
    }
  }
  
  @inlinable
  package func internalPosition(
    after position: InternalPosition
  ) -> InternalPosition? {
    switch position {
    case .intro:
      if let baseIndex = base.firstSubscriptableIndex {
        return .element(baseIndex)
      } else {
        return .outro
      }
    case .element(let baseIndex):
      precondition(baseIndex < base.endIndex)
      let nextIndex = base.index(after: baseIndex)
      if nextIndex < base.endIndex {
        return .interposition(
          InternalPosition.Interposition(
            precedingElement: baseIndex,
            subsequentElement: nextIndex
          )
        )
      } else {
        return .outro
      }
    case .interposition(let interposition):
      precondition(interposition.subsequentElement < base.endIndex)
      return .element(interposition.subsequentElement)
    case .outro:
      return nil
    }
  }
  
  // MARK: - LinearizableInternalPositionCollection API
  
  @inlinable
  package func linearPosition(forInternalPosition internalPosition: InternalPosition) -> Int {
    switch internalPosition {
    case .intro:
      return 0
    case .element(let baseIndex):
      precondition(baseIndex < base.endIndex)
      // 1 is from intro
      // 2 * base.distanceFromStart(to: baseIndex) is b/c we stride-by-two to get between base elements
      return 1 + 2 * base.distanceFromStart(to: baseIndex)
    case .interposition(let interposition):
      // 1 is from intro
      // 2 * base.distanceFromStart(to: baseIndex) is b/c we stride-by-two to get between base elements
      // 1 is to step into the interposition
      return 1 + 2 * base.distanceFromStart(to: interposition.precedingElement) + 1
    case .outro:
      // 1 is from the intro
      // base.count.impliedInterposeElementCount accounts for all of the interpose elements
      return 1 + base.count.impliedInterposeElementCount
    }
  }
  
  @inlinable
  package func internalPosition(forLinearPosition linearPosition: Int) -> InternalPosition? {
    let totalCount = count
    guard totalCount > 0 else {
      return nil
    }
    
    let introIndex = 0
    let outroIndex = totalCount - 1
    if linearPosition == outroIndex {
      return .outro
    } else if linearPosition == introIndex {
      return .intro
    }
    
    // now we're in-between, so we:
    // - correct for the intro (by substracting 1)
    // - use the same logic as within the vanilla interpose sequence (/2, then look at remainder)
    
    let adjustedLinearPosition = linearPosition - 1
    precondition(adjustedLinearPosition >= 0)
    let (baseIndexDistance, remainder) = adjustedLinearPosition.quotientAndRemainder(dividingBy: 2)
    
    let baseIndex = base.index(offsetFromStartBy: baseIndexDistance)
    precondition(baseIndex < base.endIndex)
    switch remainder == 0 {
    case true:
      return .element(baseIndex)
    case false:
      let nextBaseIndex = base.index(after: baseIndex)
      precondition(nextBaseIndex < base.endIndex)
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

extension EndcapInterposeSequence: 
  BidirectionalCollection,
  InternalPositionBidirectionalCollection
where Base: BidirectionalCollection {
  
  @inlinable
  package func internalPosition(
    before position: InternalPosition
  ) -> InternalPosition? {
    switch position {
    case .intro:
      return nil
    case .element(let elementIndex):
      switch base.subscriptableIndex(before: elementIndex) {
      case .none:
        precondition(elementIndex == base.startIndex)
        return .intro
      case .some(let previousIndex):
        return .interposition(
          InternalPosition.Interposition(
            precedingElement: previousIndex,
            subsequentElement: elementIndex
          )
        )
      }
    case .interposition(let interposition):
      return .element(interposition.precedingElement)
    case .outro:
      switch base.finalSubscriptableIndex {
      case .some(let subscriptableBaseIndex):
        return .element(subscriptableBaseIndex)
      case .none:
        return .intro
      }
    }
  }

}

// ------------------------------------------------------------------------- //
// MARK: - RandomAccessCollection
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequence:
  RandomAccessCollection,
  InternalPositionRandomAccessCollection
where Base: RandomAccessCollection {
  
}
