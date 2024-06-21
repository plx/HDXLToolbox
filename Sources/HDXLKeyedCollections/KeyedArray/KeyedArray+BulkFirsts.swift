import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Bulk Firsts
// -------------------------------------------------------------------------- //

/// ### Bulk Firsts
///
/// Contains methods for getting the first item in multiple value-sets at once.
extension KeyedArray {
  
  /// Returns a dictionary of all first-values in all arrays in `self`.
  @inlinable
  public var allFirstValues: [Key:Value] {
    pedanticAssert(isValid)
    guard !isEmpty else {
      return [:]
    }
    
    var result = [Key:Value](minimumCapacity: keyCount)
    for (key,valueList) in storage {
      guard let firstValue = valueList.first else {
        preconditionFailure(
          "We must have had invalid internal state in \(String(reflecting: self))!"
        )
      }
      result[key] = firstValue
    }
    pedanticAssert(result.count == keyCount)
    // ^ we know this should be true b/c we don't keep empty arrays around!
    return result
  }
  
  /// Returns a dictionary of all first-values in all arrays associated with a key in `keys`.
  @inlinable
  public func firstValues(
    forKeys keys: some Sequence<Key>
  ) -> [Key:Value] {
    pedanticAssert(isValid)
    guard isEmpty else {
      return [:]
    }
    
    var result = [Key:Value]()
    for key in keys where result[key] == nil {
      result[key] = storage[key]?.first
    }
    
    return result
  }
  
}
