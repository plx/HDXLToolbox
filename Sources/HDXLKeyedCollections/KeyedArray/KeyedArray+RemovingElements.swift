import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Removing Elements
// -------------------------------------------------------------------------- //

/// ### Removing Elements
///
/// Note that unlike `KeyedSet` the fact we (a) have intrinsically-ordered contents
/// and (b) our arrays can contain duplicates (etc.) means we have in some ways
/// a more-restricted set of possible APIs for doing basic removing; here in this
/// extension I only focus on dropping keys entirely, and have a separate section
/// where I have some methods for e.g. popping from the front and back.
extension KeyedArray {
  
  /// Removes all arrays from `self`, without keeping the existing capacity.
  @inlinable
  public mutating func removeAll() {
    withValidation { storage in
      storage.removeAll()
    }
  }
  
  /// Removes all arrays from `self`, keeping the existing capacity if requested.
  @inlinable
  public mutating func removeAll(keepCapacity: Bool) {
    withValidation { storage in
      storage.removeAll(keepingCapacity: keepCapacity)
    }
  }
  
  /// Removes the array for each key in `keys`.
  @inlinable
  public mutating func removeArray(
    forKey key: Key
  ) -> [Value]? {
    withValidation { storage in
      storage.removeValue(forKey: key)
    }
  }
  
  /// Removes the array for each key in `keys`.
  @inlinable
  public mutating func removeArrays(forKeys keys: some Sequence<Key>) {
    guard !isEmpty else { return }
    withValidation { storage in
      storage.removeValues(forKeys: keys)
    }
  }
    
}
