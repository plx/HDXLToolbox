import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Counts
// -------------------------------------------------------------------------- //

extension KeyedArray {
  
  /// Returns `true` iff self is completely empty.
  @inlinable
  public var isEmpty: Bool {
    storage.isEmpty
  }
  
  /// Returns the # of keys in `self`.
  @inlinable
  public var keyCount: Int {
    storage.count
  }
  
  /// Returns the total count of all contained value-arrays.
  @inlinable
  public func count(forKey key: Key) -> Int {
    storage[key]?.count ?? 0
  }
  
  /// Returns the total count of all contained value-arrays.
  @inlinable
  public var totalCount: Int {
    var count = 0
    for valueArray in storage.values {
      count += valueArray.count
    }
    pedanticAssert(count >= keyCount)
    return count
  }
  
  
  /// Returns a dictionary mapping each key in `self` to the count of its associated values.
  @inlinable
  public var keyCounts: [Key:Int] {
    pedanticAssert(isValid)
    guard !isEmpty else { return [:] }
    
    return storage.mapValues { $0.count }
  }

}

extension KeyedArray where Value:Hashable {
  
  @inlinable
  public var allDistinctValues: Set<Value> {
    Set(bulkUnionOf: storage.values)
  }
  
  /// Returns the count of *unique* values in `self` (e.g. count of the union of all value-arrays).
  /// Note that this can be somewhat expensive to calculate.
  @inlinable
  public var uniqueValueCount: Int {
    pedanticAssert(isValid)
    guard !isEmpty else { return 0 }
    
    return allDistinctValues.count
  }
  
  /// Returns a dictionary mapping each value in `self` to the # of keys with-which it's associated.
  @inlinable
  public var valueCounts: [Value:Int] {
    pedanticAssert(isValid)
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
