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
public struct Adjacent9CollectionPosition<Base> where Base: Comparable {
  
  @usableFromInline
  package typealias Storage = InlineProduct9<
    Base,
    Base,
    Base,
    Base,
    Base,
    Base,
    Base,
    Base,
    Base
  >
  
  @usableFromInline
  package var storage: Storage
  
  @inlinable
  package init(storage: Storage) {
    self.storage = storage
  }

  @inlinable
  package init(
    _ a: Base,
    _ b: Base,
    _ c: Base,
    _ d: Base,
    _ e: Base,
    _ f: Base,
    _ g: Base,
    _ h: Base,
    _ i: Base
  ) {
    self.init(
      storage: Storage(
        a,
        b,
        c,
        d,
        e,
        f,
        g,
        h,
        i
      )
    )
  }

}

// -------------------------------------------------------------------------- //
// MARK: - Comparable
// -------------------------------------------------------------------------- //

extension Adjacent9CollectionPosition: Comparable {
  
  @inlinable
  public static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs
      .storage
      .lexicographicOrderingRelationship(with: rhs.storage)
      .impliesLessThan
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: - Validatable
// -------------------------------------------------------------------------- //

extension Adjacent9CollectionPosition {
  
  @inlinable
  package var hasConsistentInternalState: Bool {
    guard
      storage.a < storage.b,
      storage.b < storage.c,
      storage.c < storage.d,
      storage.d < storage.e,
      storage.e < storage.f,
      storage.f < storage.g,
      storage.g < storage.h,
      storage.h < storage.i
    else {
      return false
    }
    return true
  }
  
}

