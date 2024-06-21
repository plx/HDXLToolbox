import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: - Value-Sorting, Arbitrary Ordering
// -------------------------------------------------------------------------- //

extension KeyedArray {
  
  /// Returns a keyed-array derived from `self` but with all of its arrays sorted
  /// using the supplied `isOrderedBefore` closure.
  ///
  /// - note: I would prefer that `isOrderedBefore` be labeled as `@noescape` but
  ///         it seems that the actual `sort` method lacks that annotation (mistakenly?),
  ///         and thus thes methods aren't able to include that annotation, either.
  @inlinable
  public func sorted(
    by isOrderedBefore: (Value, Value) throws -> Bool
  ) rethrows -> Self {
    pedanticAssert(isValid)
    guard !isEmpty else { return self }
    
    var result: Storage = [:]
    for (key, values) in storage {
      result[key] = try values.sorted(by: isOrderedBefore)
    }
    
    return Self(storage: result)
  }
  /// Updates `self` in-place by sorting each value-array using the supplied closure.
  ///
  /// - note: I would prefer that `isOrderedBefore` be labeled as `@noescape` but
  ///         it seems that the actual `sort` method lacks that annotation (mistakenly?),
  ///         and thus thes methods aren't able to include that annotation, either.
  @inlinable
  public mutating func sort(
    by isOrderedBefore: (Value, Value) throws -> Bool
  ) rethrows {
    guard !isEmpty else { return }
    try withValidation { storage in
      try storage.inPlaceCompleteMutationWithoutRemoval { (values) in
        try values.sort(by: isOrderedBefore)
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Value-Sorting, `Comparable`
// -------------------------------------------------------------------------- //

extension KeyedArray where Value: Comparable {
  
  /// Returns a keyed-array derived from `self` but with all of its arrays sorted
  /// using the supplied `isOrderedBefore` closure.
  ///
  /// - note: I would prefer that `isOrderedBefore` be labeled as `@noescape` but
  ///         it seems that the actual `sort` method lacks that annotation (mistakenly?),
  ///         and thus thes methods aren't able to include that annotation, either.
  @inlinable
  public func sorted() -> Self {
    pedanticAssert(isValid)
    guard !isEmpty else { return self }
    
    return Self(
      storage: Storage(
        uniqueKeysWithValues: storage.onDemandMap { (key, values) in
          (key, values.sorted())
        }
      )
    )
  }
  /// Updates `self` in-place by sorting each value-array using the supplied closure.
  ///
  /// - note: I would prefer that `isOrderedBefore` be labeled as `@noescape` but
  ///         it seems that the actual `sort` method lacks that annotation (mistakenly?),
  ///         and thus thes methods aren't able to include that annotation, either.
  @inlinable
  public mutating func sort() {
    guard !isEmpty else { return }
    withValidation { storage in
      storage.inPlaceCompleteMutationWithoutRemoval { (values) in
        values.sort()
      }
    }
  }
  
}
