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
public struct CabooseCollectionIndex<Base>: PositionIndexStorageWrapper where Base: Comparable {

  @usableFromInline
  package typealias Position = CabooseCollectionPosition<Base>
  
  @usableFromInline
  package typealias Storage = PositionIndexStorage<Position>
  
  @usableFromInline
  package var storage: Storage
  
  @inlinable
  package init(storage: Storage) {
    self.storage = storage
  }

  @usableFromInline
  internal static var caboose: Self {
    Self(position: .caboose)
  }
  
}
