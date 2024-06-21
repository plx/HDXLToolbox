import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Queue-Emulation Support
// -------------------------------------------------------------------------- //

/// ### Queue-Emulation Support
///
/// Contains methods for "popping" items from the "front" or "back" of a value-array,
/// including managing the removal of empty arrays if necessary.
extension KeyedArray {
  
  /// Pops the first value for `key`, if there is one.
  @inlinable
  public mutating func popFirst(
    forKey key: Key
  ) -> Value? {
    pedanticAssert(isValid)
    guard !isEmpty else { return nil }
    
    return withValidation { (storage) in
      storage.inPlaceStrictlyDecreasingMutationWithAutomaticEmptyRemoval(forKey: key) { (values)
        in
        values.popFirstElement()
      }
    }
  }
  
  /// Pops the last value for `key`, if there is one.
  @inlinable
  public mutating func popLast(forKey key: Key) -> Value? {
    pedanticAssert(isValid)
    guard !isEmpty else { return nil }
    
    return withValidation { (storage) in
      storage.inPlaceStrictlyDecreasingMutationWithAutomaticEmptyRemoval(forKey: key) { (values)
        in
        values.popLast()
      }
    }
  }
  
}
