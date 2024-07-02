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
public struct InterposeCollectionIndex<Base>: PositionIndexStorageWrapper where Base: Comparable {
  
  @usableFromInline
  package typealias Position = InterposeCollectionPosition<Base>
  
  @usableFromInline
  package typealias Interposition = InterpositionElement<Base>
  
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
  internal static func interposition(
    precedingElement: Base,
    subsequentElement: Base
  ) -> Self {
    Self(
      storage: .position(
        .interposition(
          Interposition(
            precedingElement: precedingElement,
            subsequentElement: subsequentElement
          )
        )
      )
    )
  }
}
