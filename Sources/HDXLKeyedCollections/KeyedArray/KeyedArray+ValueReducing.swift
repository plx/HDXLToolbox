import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Value-Reducing
// -------------------------------------------------------------------------- //

/// ### Value-Reducing
///
/// Methods for doing various types of "keywise" reductions on a KeyedArray.
extension KeyedArray {
  
  /// Does a "naive" key-wise reduction on each key's content. Note that the
  /// `initialValue` parameter is an `@autoclosure` argument and gets evaluated
  /// once per reduction; this is to make it safe to use non-value types in the reduction.
  @inlinable
  public func homogeneousValueReduction<T>(
    usingInitialValue initialValue: @autoclosure () throws -> T,
    _ nextPartialResult: (T,Value) throws -> T
  ) rethrows -> [Key:T] {
    pedanticAssert(isValid)
    guard !isEmpty else { return [:] }
    
    var result = [Key:T](minimumCapacity: keyCount)
    for (key, values) in storage {
      result[key] = try values.reduce(
        initialValue(),
        nextPartialResult
      )
    }
    
    return result
  }

  @inlinable
  public func keyDependentValueReduction<T>(
    initialValue: (Key) throws -> T,
    valueReducer nextPartialResult: (T,Value) throws -> T
  ) rethrows -> [Key:T] {
    pedanticAssert(isValid)
    guard !isEmpty else { return  [:] }
    
    var result = [Key:T](minimumCapacity: keyCount)
    for (key, values) in storage {
      result[key] = try values.reduce(
        initialValue(key),
        nextPartialResult
      )
    }
    
    return result
  }

  @inlinable
  public func keyDependentValueReduction<T>(
    initialValue: (Key) throws -> T,
    keyValueReducer nextPartialResult: (T,(Key,Value)) throws -> T
  ) rethrows -> [Key:T] {
    pedanticAssert(isValid)
    guard !isEmpty else { return [:] }
    
    var result = [Key:T](minimumCapacity: keyCount)
    for (key, values) in storage {
      result[key] = try values.reduce(initialValue(key)) { (partialResult, value) in
        try nextPartialResult(partialResult, (key, value))
      }
    }
    
    return result
  }
  
}
