import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

extension KeyedArray where Value: Hashable {
  
  @inlinable
  public func reducedToKeyedSet() -> KeyedSet<Key, Value> {
    pedanticAssert(isValid)
    return KeyedSet<Key, Value>(
      storage: KeyedSet<Key, Value>.Storage(
        uniqueKeysWithValues: storage.onDemandMap { key, values in
          (key, Set(values))
        }
      )
    )
  }
  
  @inlinable
  public func reducedToDictionary<T>(
    _ transform: ([Value]) throws -> T
  ) rethrows -> [Key:T] {
    pedanticAssert(isValid)
    
    var result: [Key:T] = [:]
    for (key, values) in storage {
      result[key] = try transform(values)
    }
    return result
  }

  @inlinable
  public func reducedToDictionary<T>(
    _ transform: (Key, [Value]) throws -> T
  ) rethrows -> [Key:T] {
    pedanticAssert(isValid)
    
    var result: [Key:T] = [:]
    for (key, values) in storage {
      result[key] = try transform(key, values)
    }
    return result
  }

}

/// ### Mapped KeyedSet Conversion
///
/// Since a `KeyedArray` doesn't require that its `V` be `Hashable`, in the general
/// setting the only way to convert it to a keyed-set is to map its values to values
/// that are `Hashable`.
extension KeyedArray {
  
  /// Creates a keyed set by mapping the contents of `self` using `map`.
  @inlinable
  public func mappedKeyedSet<T>(
    _ transform: (Value) throws -> T
  ) rethrows -> KeyedSet<Key,T> where T: Hashable {
    pedanticAssert(isValid)
    guard !isEmpty else { return KeyedSet<Key,T>() }
    
    
    var result: KeyedSet<Key, T>.Storage = [:]
    for (key, values) in storage {
      var transformedValueSet: Set<T> = []
      for value in values {
        transformedValueSet.insert(try transform(value))
      }
      result[key] = transformedValueSet
    }
    return KeyedSet<Key, T>(
      storage: result
    )
  }
  
}
