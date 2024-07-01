import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

@frozen
@ConditionallySendable
@AlwaysEquatable
@AlwaysComparable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyAutoIdentifiable
public struct InterjectionCollectionIndex<Base>: PositionIndexStorageWrapper where Base: Comparable {
  
  @usableFromInline
  package typealias Position = InterjectionCollectionPosition<Base>
  
  @usableFromInline
  package typealias Storage = PositionIndexStorage<Position>
  
  @usableFromInline
  package var storage: Storage
  
  @inlinable
  package init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  internal static func element(at baseIndex: Base) -> Self {
    Self(
      storage: .position(
        .element(baseIndex)
      )
    )
  }

  @inlinable
  internal static func injection(
    between earlierIndex: Base,
    _ laterIndex: Base
  ) -> Self {
    Self(
      storage: .position(
        .interjection(
          Position.Interjection(
            precedingElement: earlierIndex,
            subsequentElement: laterIndex
          )
        )
      )
    )
  }

}

