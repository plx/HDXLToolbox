import Foundation
import HDXLEssentialPrecursors
import HDXLAlgebraicTypes
import HDXLCollectionSupport
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Adjacent9CollectionIndex - Definition
// -------------------------------------------------------------------------- //

/// Index for the arity-9 adjacent-tuple collection.
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyEncodable
@ConditionallyDecodable
public struct Adjacent9CollectionIndex<Base>: PositionIndexStorageWrapper where Base: Comparable {
  
  @usableFromInline
  package typealias Position = Adjacent9CollectionPosition<Base>
  
  @usableFromInline
  package var storage: PositionIndexStorage<Position>
  
  @inlinable
  package init(storage: PositionIndexStorage<Position>) {
    self.storage = storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: Adjacent9CollectionIndex - Validatable
// -------------------------------------------------------------------------- //

extension Adjacent9CollectionIndex {
  
  @inlinable
  package var hasConsistentInternalState: Bool {
    guard case .position(let position) = storage else {
      return true
    }
    
    return position.hasConsistentInternalState
  }
  
}

