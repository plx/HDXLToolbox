import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Reverse Lookups - Equatable
// -------------------------------------------------------------------------- //

/// ### Reverse-Lookups - Equatable Values
///
/// Some handy methods when `V` is actually equatable.
extension KeyedArray where Value: Equatable {
  
  /// Returns a dictionary mapping keys to the *first* index in their associated arrays storing a value equal-to `value`.
  @inlinable
  public func firstIndices(
    forValue value: Value
  ) -> [Key:Int] {
    pedanticAssert(isValid)
    guard !isEmpty else { return [:] }
    
    var result = [Key:Int]()
    for (key, values) in storage {
      result[key] = values.firstIndex(of: value)
    }
    
    return result
  }

  /// Returns a dictionary mapping keys to the *last* index in their associated arrays storing a value equal-to `value`.
  @inlinable
  public func lastIndices(
    forValue value: Value
  ) -> [Key:Int] {
    pedanticAssert(isValid)
    guard !isEmpty else { return [:] }
    
    var result = [Key:Int]()
    for (key, values) in storage {
      result[key] = values.lastIndex(of: value)
    }
    
    return result
  }

  /// Returns the set of keys with-which `value` is associated in `self`.
  @inlinable
  public func keys(
    forValue value: Value
  ) -> Set<Key> {
    pedanticAssert(isValid)
    guard !isEmpty else { return [] }
    
    var result: Set<Key> = []
    for (key, values) in storage where values.contains(value) {
      result.insert(key)
    }
    
    return result
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Reverse Lookups
// -------------------------------------------------------------------------- //

/// ### Reverse-Lookups
///
/// Methods for doing reverse "lookups" that take an arbitrary predicate.
extension KeyedArray {
  
  /// Returns a dictionary mapping keys to the first indices in their associated arrays satisfying `predicate`.
  @inlinable
  public func firstIndicesSatisfying(
    _ predicate: (Value) throws -> Bool
  ) rethrows -> [Key:Int] {
    pedanticAssert(isValid)
    guard !isEmpty else { return [:] }
    
    var result = [Key:Int]()
    for (key, values) in storage {
      result[key] = try values.firstIndex(where: predicate)
    }
    
    return result
  }

  /// Returns a dictionary mapping keys to the last indices in their associated arrays satisfying `predicate`.
  @inlinable
  public func lastIndicesSatisfying(
    _ predicate: (Value) throws -> Bool
  ) rethrows -> [Key:Int] {
    pedanticAssert(isValid)
    guard !isEmpty else { return [:] }
    
    var result = [Key:Int]()
    for (key, values) in storage {
      result[key] = try values.lastIndex(where: predicate)
    }
    
    return result
  }

}
