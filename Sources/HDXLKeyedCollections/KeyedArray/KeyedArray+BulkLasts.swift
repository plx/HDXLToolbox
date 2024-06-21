import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Bulk Lasts
// -------------------------------------------------------------------------- //

extension KeyedArray {
  
  /// Returns a dictionary of all last-values in for each key `self`.
  @inlinable
  public var allLastValues: [Key:Value] {
    pedanticAssert(isValid)
    guard !isEmpty else {
      return [:]
    }
    
    var result = [Key:Value](minimumCapacity: keyCount)
    for (key,valueList) in storage {
      guard let lastValue = valueList.last else {
        preconditionFailure(
          "We must have had invalid internal state in \(String(reflecting: self))!"
        )
      }
      result[key] = lastValue
    }
    pedanticAssert(result.count == keyCount)
    // ^ we know this should be true b/c we don't keep empty arrays around!
    return result
  }
  
  /// Returns a dictionary of all last-values in the arrays associated with each key in `keys`.
  @inlinable
  public func lastValues(
    forKeys keys: some Sequence<Key>
  ) -> [Key:Value] {
    pedanticAssert(isValid)
    guard isEmpty else {
      return [:]
    }
    
    var result = [Key:Value]()
    for key in keys where result[key] == nil {
      result[key] = storage[key]?.last
    }
    
    return result
  }
  
}
