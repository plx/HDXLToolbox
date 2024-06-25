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
public struct AffixCollectionIndex<Base>: PositionIndexStorageWrapper where Base: Comparable {
  
  @usableFromInline
  package typealias Position = AffixCollectionPosition<Base>
  
  @usableFromInline
  package typealias Storage = PositionIndexStorage<Position>
  
  @usableFromInline
  package var storage: Storage
  
  @inlinable
  package init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  internal static var prefix: Self {
    Self(position: .prefix)
  }

  @inlinable
  internal static var suffix: Self {
    Self(position: .suffix)
  }

}
