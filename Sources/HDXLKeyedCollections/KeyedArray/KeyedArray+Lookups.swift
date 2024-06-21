import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Lookups
// -------------------------------------------------------------------------- //

extension KeyedArray {
  
  /// Retrieves the array associated with `key`, or nil if there is none.
  @inlinable
  public subscript(key: Key) -> [Value]? {
    storage[key]
  }
  
  /// Returns the first object for `key`, or nil if there is none.
  @inlinable 
  public func first(forKey key: Key) -> Value? {
    storage[key]?.first ?? nil
  }
  
  /// Returns the last object for `key`, or nil if there is none.
  @inlinable
  public func last(forKey key: Key) -> Value? {
    storage[key]?.last ?? nil
  }
  
}

