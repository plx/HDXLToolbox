import Foundation
import HDXLEssentialPrecursors

@frozen
public struct AdjacentPairCollectionIndex<Base>: Comparable where Base: Comparable {
  @usableFromInline
  internal typealias Position = AdjacentPair<Base>
  
  @usableFromInline
  internal var position: Position?

  @inlinable
  internal init(
    earlierIndex: Base,
    laterIndex: Base
  ) {
    precondition(earlierIndex < laterIndex)
    self.init(
      position: Position(
        earlierElement: earlierIndex,
        laterElement: laterIndex
      )
    )
  }

  @inlinable
  internal init(position: Position) {
    self.position = position
  }
  
  @inlinable
  internal init(__unsafePosition position: Position?) {
    self.position = position
  }
  
  @inlinable
  internal static var endIndex: Self {
    Self(__unsafePosition: nil)
  }
  
  @inlinable
  public static func < (
    lhs: AdjacentPairCollectionIndex<Base>,
    rhs: AdjacentPairCollectionIndex<Base>
  ) -> Bool {
    switch (lhs.position, rhs.position) {
    case (.some(let l), .some(let r)):
      ComparisonResult.coalescing(
        l.earlierElement <=> r.earlierElement,
        l.laterElement <=> r.laterElement
      ).impliesLessThan
    case (.some, .none):
      true
    case (.none, .some):
      false
    case (.none, .none):
      false
    }
  }
}

extension AdjacentPairCollectionIndex: Sendable where Base: Sendable { }
extension AdjacentPairCollectionIndex: Hashable where Base: Hashable { }
extension AdjacentPairCollectionIndex: Encodable where Base: Encodable { }
extension AdjacentPairCollectionIndex: Decodable where Base: Decodable { }

