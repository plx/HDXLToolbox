import Foundation
import HDXLEssentialPrecursors

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
public struct EndcapInterposeSequence<Intro, Outro, Base>: Sequence where Base: Sequence {
  public typealias Iterator = EndcapInterposeSequenceIterator<Intro, Outro, Base.Iterator>
  public typealias BaseElement = Base.Element
  public typealias Interposition = InterpositionElement<BaseElement>

  @usableFromInline
  internal let intro: Intro

  @usableFromInline
  internal let outro: Outro

  @usableFromInline
  internal let base: Base
  
  @inlinable
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
      baseIterator: base.makeIterator())
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequence: Sendable where Intro: Sendable, Outro: Sendable, Base: Sendable { }
extension EndcapInterposeSequence: Equatable where Intro: Equatable, Outro: Equatable, Base: Equatable { }
extension EndcapInterposeSequence: Hashable where Intro: Hashable, Outro: Hashable, Base: Hashable { }
extension EndcapInterposeSequence: Encodable where Intro: Encodable, Outro: Encodable, Base: Encodable { }
extension EndcapInterposeSequence: Decodable where Intro: Decodable, Outro: Decodable, Base: Decodable { }

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
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequence: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    "EndcapInterposeSequence<\(String(reflecting: intro)), \(String(reflecting: outro)), \(String(reflecting: Base.self))>(intro: \(String(reflecting: intro)), outro: \(String(reflecting: outro)), base: \(String(reflecting: base)))"
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Collection
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequence: Collection where Base: Collection {
  public typealias Index = EndcapInterposeCollectionIndex<Base.Index>
  
  @inlinable
  public var isEmpty: Bool {
    false
  }
  
  @inlinable
  public var count: Int {
    base.count.impliedEndcapInterposeElementCount
  }
  
  @inlinable
  public var startIndex: Index {
    .intro
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
    case .intro:
      return .intro(intro)
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
    case .outro:
      return .outro(outro)
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
    case .intro:
      switch base.firstSubscriptableIndex {
      case .some(let baseIndex):
        return Index(index: baseIndex)
      case .none:
        return .outro
      }
    case .element(let baseIndex):
      let nextBaseIndex = base.index(after: baseIndex)
      switch nextBaseIndex == base.endIndex {
      case true:
        return .outro
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
    case .outro:
      return .endIndex
    }
  }

}

// ------------------------------------------------------------------------- //
// MARK: - BidirectionalCollection
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequence: BidirectionalCollection where Base: BidirectionalCollection {
  
  @inlinable
  public func index(
    before i: Index
  ) -> Index {
    guard let position = i.position else {
      return .outro
    }
    switch position {
    case .intro:
      fatalAttemptToGoBackFromStartIndex(i)
    case .element(let baseIndex):
      switch baseIndex == base.startIndex {
      case true:
        return .intro
      case false:
        return Index(
          interposition: Index.Interposition(
            precedingElement: base.index(before: baseIndex),
            subsequentElement: baseIndex
          )
        )
      }
    case .interposition(let baseInterposition):
      return Index(index: baseInterposition.precedingElement)
    case .outro:
      guard let finalSubscriptableBaseIndex = base.finalSubscriptableIndex else {
        return .intro
      }
      return Index(index: finalSubscriptableBaseIndex)
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: - RandomAccessCollection
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequence: RandomAccessCollection where Base: RandomAccessCollection { }
