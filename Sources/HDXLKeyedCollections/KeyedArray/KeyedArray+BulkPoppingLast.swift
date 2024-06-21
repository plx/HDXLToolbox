import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Bulk-Popping Last
// -------------------------------------------------------------------------- //

/// ### Bulk-Popping Last
///
/// Methods for doing "aggregate" bulk-pop-last operations on a keyed-array.
extension KeyedArray {
  
  /// Bulk-pops the last element from the arrays for each key in `self`.
  @inlinable
  public mutating func popAllLasts() -> [Key:Value] {
    pedanticAssert(isValid)
    guard !isEmpty else {
      return [:]
    }
    
    return withValidation { storage in
      var result = [Key:Value](minimumCapacity: storage.count)
      storage.inPlaceCompleteMutationWithAutomaticEmptyRemoval { key, values in
        result[key] = values.popLast()
      }
      
      return result
    }
  }
  
  /// Bulk-pops the last element from the arrays for each key in `keys`.
  @inlinable
  public mutating func popLast(
    forKeys keys: some Sequence<Key>
  ) -> [Key:Value] {
    pedanticAssert(isValid)
    guard !isEmpty else {
      return [:]
    }
    
    return withValidation { storage in
      var result = [Key:Value](minimumCapacity: storage.count)
      for key in keys where result[key] == nil{
        guard
          let index = storage.index(forKey: key),
          let poppedValue = storage.values[index].popLast()
        else {
          continue
        }
        
        result[key] = poppedValue
        if storage.values[index].isEmpty {
          storage.remove(at: index)
          if storage.isEmpty {
            break
          }
        }
        
      }
      
      return result
    }
  }
    
}
