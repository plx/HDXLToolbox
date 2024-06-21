import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

extension KeyedSet {
  
  @inlinable
  public mutating func insert(
    value: Value,
    forKey key: Key
  ) {
    withValidation {
      (storage)
      in
      storage.inPlaceStriclyIncreasingMutation(
        key: key
      ) { 
        valueSet
        in
        valueSet.insert(value)
      }
    }
  }

  @inlinable
  public mutating func insert(
    values: Set<Value>,
    forKey key: Key
  ) {
    guard !values.isEmpty else {
      return
    }
    withValidation {
      (storage)
      in
      storage.inPlaceStriclyIncreasingMutation(
        key: key
      ) {
        valueSet
        in
        valueSet.formUnion(values)
      }
    }
  }

  @inlinable
  public mutating func insert(
    values: some Sequence<Value>,
    forKey key: Key
  ) {
    withValidation {
      (storage)
      in
      storage.inPlaceNonDecreasingMutation(key: key) {
        valueSet
        in
        valueSet.formUnion(values)
      }
    }
  }

  @inlinable
  public mutating func insert(
    values: some Collection<Value>,
    forKey key: Key
  ) {
    guard !values.isEmpty else { return }
    withValidation {
      (storage)
      in
      storage.inPlaceStriclyIncreasingMutation(key: key) {
        valueSet
        in
        valueSet.formUnion(values)
      }
    }
  }

}

extension KeyedSet {
  
  @inlinable
  public mutating func insert(
    value: Value,
    forKeys keys: Set<Key>
  ) {
    guard !keys.isEmpty else { return }
    withValidation {
      (storage)
      in
      storage.inPlaceStriclyIncreasingMutation(
        keys: keys
      ) {
        valueSet
        in
        valueSet.insert(value)
      }
    }
  }

  @inlinable
  public mutating func insert(
    value: Value,
    forKeys keys: some Sequence<Key>
  ) {
    withValidation {
      (storage)
      in
      storage.inPlaceStriclyIncreasingMutation(
        keys: keys
      ) {
        valueSet
        in
        valueSet.insert(value)
      }
    }
  }

  @inlinable
  public mutating func insert(
    value: Value,
    forKeys keys: some Collection<Key>
  ) {
    guard !keys.isEmpty else { return }
    withValidation {
      (storage)
      in
      storage.inPlaceStriclyIncreasingMutation(
        keys: keys
      ) {
        valueSet
        in
        valueSet.insert(value)
      }
    }
  }

  @inlinable
  public mutating func insert(
    values: Set<Value>,
    forKeys keys: Set<Key>
  ) {
    guard !values.isEmpty && !keys.isEmpty else {
      return
    }
    withValidation {
      (storage)
      in
      storage.inPlaceStriclyIncreasingMutation(keys: keys) {
        valueSet
        in
        valueSet.formUnion(values)
      }
    }
  }
    
  @inlinable
  public mutating func insert(
    values: some Collection<Value>,
    forKeys keys: some Sequence<Key>
  ) {
    guard !values.isEmpty else { return }
    withValidation {
      (storage)
      in
      storage.inPlaceStriclyIncreasingMutation(keys: keys) {
        valueSet
        in
        valueSet.formUnion(values)
      }
    }
  }

  @inlinable
  public mutating func insert(
    values: some Collection<Value>,
    forKeys keys: some Collection<Key>
  ) {
    guard !values.isEmpty && keys.isEmpty else { return }
    withValidation {
      (storage)
      in
      storage.inPlaceStriclyIncreasingMutation(keys: keys) {
        valueSet
        in
        valueSet.formUnion(values)
      }
    }
  }

}
