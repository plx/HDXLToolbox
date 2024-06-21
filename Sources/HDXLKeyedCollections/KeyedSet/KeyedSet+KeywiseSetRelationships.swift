import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// ------------------------------------------------------------------------- //
// MARK: Set Relationships
// ------------------------------------------------------------------------- //

extension KeyedSet {
  
  @inlinable
  public func isKeywiseDisjoint(with other: Self) -> Bool {
    pedanticAssert(hasConsistentInternalState)
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty && !other.isEmpty else { return true }
    
    let (smaller, larger) = smallerThenLarger(
      storage,
      other.storage
    )
    
    for key in smaller.keys where larger[key] != nil {
      return false
    }
    
    return true
  }

  @inlinable
  public func hasKeywiseIntersection(with other: Self) -> Bool {
    !isKeywiseDisjoint(with: other)
  }

  @inlinable
  public func isKeywiseSubset(of other: Self) -> Bool {
    pedanticAssert(hasConsistentInternalState)
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty else { return true }
    guard !other.isEmpty else { return false }
    
    for (key, valueSet) in storage {
      guard
        let otherValueSet = other.storage[key],
        valueSet.isSubset(of: otherValueSet)
      else {
        return false
      }
    }
    
    return true
  }

  @inlinable
  public func isKeywiseStrictSubset(of other: Self) -> Bool {
    pedanticAssert(hasConsistentInternalState)
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty else { return true }
    guard !other.isEmpty else { return false }
    
    for (key, valueSet) in storage {
      guard
        let otherValueSet = other.storage[key],
        valueSet.isStrictSubset(of: otherValueSet)
      else {
        return false
      }
    }
    
    return true
  }

  @inlinable
  public func isKeywiseSuperset(of other: Self) -> Bool {
    other.isKeywiseSubset(of: self)
  }

  @inlinable
  public func isKeywiseStrictSuperset(of other: Self) -> Bool {
    other.isKeywiseStrictSubset(of: self)
  }

}
