import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedSet - Inversion
// -------------------------------------------------------------------------- //

/// ### Inversion
///
/// Methods for getting a "flipped" KeyedSet.
extension KeyedSet {
  
  /// Returns a keyed-set in which the keys are the values in `self`, and the
  /// associated value-sets are the sets of keys from `self` with which the values
  /// were associated in `self`.
  @inlinable
  public var inverted: KeyedSet<Value,Key> {
    guard !isEmpty else {
      return KeyedSet<Value,Key>()
    }
    
    // TODO: evaluate non-default choice of minimum-capacity
    var invertedStorage: KeyedSet<Value,Key>.Storage = [:]
    for (key, valueSet) in storage {
      for value in valueSet {
        invertedStorage[
          value,
          default: []
        ].insert(key)
      }
    }
    
    return KeyedSet<Value,Key>(
      storage: invertedStorage
    )
  }
  
}

extension KeyedSet where Key == Value {
  
  @inlinable
  public mutating func formInverse() {
    guard !isEmpty else { return }
    withValidation {
      (storage)
      in
      var replacementStorage: Storage = [:]
      for (key, valueSet) in storage {
        for value in valueSet {
          replacementStorage[
            value,
            default: []
          ].insert(key)
        }
      }
      
      storage = replacementStorage
    }
  }
  
}
