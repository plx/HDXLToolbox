import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Value Mapping
// -------------------------------------------------------------------------- //

/// ### Value Mapping
///
/// Contains various methods for deriving new keyed-arrays by mapping the value-lists
/// to new value-lists item-by-item.
extension KeyedArray {
  
  /// Creates a derived keyed-array by mapping the contents of each value-list using `map`.
  @inlinable
  public func mapValues<T>(
    _ transform: (Value) throws -> T
  ) rethrows -> KeyedArray<Key,T> {
    pedanticAssert(isValid)
    guard !isEmpty else { return KeyedArray<Key,T>() }
    
    var result: KeyedArray<Key,T>.Storage = [:]
    for (key, values) in storage {
      result[key] = try values.map(transform)
    }
    
    return KeyedArray<Key,T>(
      storage: result
    )
  }
    
}
