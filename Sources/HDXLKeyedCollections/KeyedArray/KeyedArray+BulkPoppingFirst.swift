import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Bulk-Popping First
// -------------------------------------------------------------------------- //

extension Array {
  
  @inlinable
  internal mutating func popFirstElement() -> Element? {
    guard !isEmpty else {
      return nil
    }
    
    return remove(at: 0)
  }
  
}

extension KeyedArray {
  
  /// Bulk-pops the first element from the array for all keys in `self`.
  @inlinable
  public mutating func popAllFirsts() -> [Key:Value] {
    pedanticAssert(isValid)
    guard !isEmpty else {
      return [:]
    }
    
    return withValidation { storage in
      var result = [Key:Value](minimumCapacity: storage.count)
      storage.inPlaceCompleteMutationWithAutomaticEmptyRemoval { key, values in
        guard !values.isEmpty else { return }
        result[key] = values.remove(at: 0)
      }
      
      pedanticAssert(result.count == storage.count)
      return result
    }
  }
  
  /// Bulk-pops the first element from the array for all keys in `keys`.
  @inlinable
  public mutating func popFirst(
    forKeys keys: some Sequence<Key>
  ) -> [Key:Value] {
    pedanticAssert(isValid)
    guard !isEmpty else {
      return [:]
    }
    
    return withValidation { storage in
      var result = [Key:Value](minimumCapacity: storage.count)
      for key in keys where result[key] == nil {
        guard
          let index = storage.index(forKey: key),
          let poppedValue = storage.values[index].popFirstElement()
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
