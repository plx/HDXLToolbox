import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

extension KeyedSet {
  
  @inlinable
  public var keyCount: Int {
    storage.count
  }
  
  @inlinable
  public var pairCount: Int {
    var count: Int = 0
    for valueSet in storage.values {
      count += valueSet.count
    }
    
    return count
  }
  
  @inlinable
  public func count(forKey key: Key) -> Int {
    storage[key]?.count ?? 0
  }
  
  @inlinable
  public func count(forValue value: Value) -> Int {
    var count: Int = 0
    for valueSet in storage.values where valueSet.contains(value) {
      count += 1
    }
    
    return count
  }
  
  @inlinable
  public var keyCounts: [Key: Int] {
    [Key: Int](
      uniqueKeysWithValues: storage.onDemandMap { key, valueSet in
        (
          key,
          valueSet.count
        )
      }
    )
  }
  
  @inlinable
  public func countsForKeys(keys: Set<Key>) -> [Key: Int] {
    guard !isEmpty && !keys.isEmpty else {
      return [:]
    }
    
    return [Key: Int](fromLazyTransformationOf: keys) { key in
      (key, storage[key]?.count ?? 0)
    }
  }

  @inlinable
  public func countsForKeys(keys: some Sequence<Key>) -> [Key: Int] {
    guard !isEmpty else {
      return [:]
    }
    
    var result = [Key: Int](minimumCapacity: keys.underestimatedCount)
    for key in keys where result[key] == nil {
      result[key] = storage[key]?.count ?? 0
    }
    
    return result
  }

  @inlinable
  public func countsForKeys(keys: some Collection<Key>) -> [Key: Int] {
    guard !isEmpty && !keys.isEmpty else {
      return [:]
    }
    
    var result = [Key: Int](minimumCapacity: keys.count)
    for key in keys where result[key] == nil {
      result[key] = storage[key]?.count ?? 0
    }
    
    return result
  }

}

extension KeyedSet where Value:Hashable {
  
  @inlinable
  public var allDistinctValues: Set<Value> {
    Set(bulkUnionOf: storage.values)
  }
  
  /// Returns the count of *unique* values in `self` (e.g. count of the union of all value-arrays).
  /// Note that this can be somewhat expensive to calculate.
  @inlinable
  public var uniqueValueCount: Int {
    pedanticAssert(hasConsistentInternalState)
    guard !isEmpty else { return 0 }
    
    return allDistinctValues.count
  }
  
  /// Returns a dictionary mapping each value in `self` to the # of keys with-which it's associated.
  @inlinable
  public var valueCounts: [Value:Int] {
    pedanticAssert(hasConsistentInternalState)
    guard !isEmpty else { return [:] }
    
    var valueCounts: [Value:Int] = [:]
    for valueArray in storage.values {
      for value in valueArray {
        valueCounts[
          value,
          default: 0
        ] += 1
      }
    }
    
    return valueCounts
  }
  
}
