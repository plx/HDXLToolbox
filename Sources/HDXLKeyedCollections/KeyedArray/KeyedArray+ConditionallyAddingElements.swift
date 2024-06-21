import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Conditionally-Adding Elements
// -------------------------------------------------------------------------- //

extension KeyedArray {
  
  /// Prepends`value` onto an *existing* array associated-with `key`.
  @inlinable
  public mutating func prepend(
    value: Value,
    forExistingKey key: Key
  ) {
    guard !isEmpty else { return }
    withValidation { (storage) in
      guard let index = storage.index(forKey: key) else {
        return
      }
      storage
        .values[index]
        .insert(
          value,
          at: index
        )
    }
  }
  
  /// Prepends each value in `values` onto an *existing* array for `key`.
  @inlinable
  public mutating func prepend(
    values: some Sequence<Value>,
    forExistingKey key: Key
  ) {
    guard !isEmpty else { return }
    withValidation { (storage) in
      guard let index = storage.index(forKey: key) else {
        return
      }
      storage
        .values[index]
        .insert(
          contentsOf: values,
          at: 0
        )
    }
  }
  
  /// Prepends `value` onto an *existing* array associated-with `key`.
  @inlinable
  public mutating func prepend(
    value: Value,
    forExistingKeys keys: some Sequence<Key>
  ) {
    guard !isEmpty else { return }
    withValidation { (storage) in
      for key in keys {
        guard let index = storage.index(forKey: key) else {
          continue
        }
        storage
          .values[index]
          .insert(
            value,
            at: 0
          )
      }
    }
  }
  
  /// Prepends each value in `values` onto any *existing* arrays for each key in `keys`.
  @inlinable
  public mutating func prepend(
    values: some Collection<Value>,
    forExistingKeys keys: some Sequence<Key>
  ) {
    guard !isEmpty else { return }
    withValidation { (storage) in
      for key in keys {
        guard let index = storage.index(forKey: key) else {
          continue
        }
        storage
          .values[index]
          .insert(
            contentsOf: values,
            at: 0
          )
      }
    }
  }
  
}

extension KeyedArray {
  
  /// Appends `value` onto an *existing* array associated-with `key`.
  @inlinable
  public mutating func append(
    value: Value,
    forExistingKey key: Key
  ) {
    guard !isEmpty else { return }
    withValidation { (storage) in
      guard let index = storage.index(forKey: key) else {
        return
      }
      storage
        .values[index]
        .append(value)
    }
  }
  
  /// Appends each value in `values` onto an *existing* array associated-with `key`.
  @inlinable
  public mutating func append(
    values: some Sequence<Value>,
    forExistingKey key: Key
  ) {
    guard !isEmpty else { return }
    withValidation { (storage) in
      guard let index = storage.index(forKey: key) else {
        return
      }
      storage
        .values[index]
        .append(contentsOf: values)
    }
  }
  
  /// Appends `value` onto any *existing* arrays for each key in `keys`.
  @inlinable
  public mutating func append(
    value: Value,
    forExistingKeys keys: some Sequence<Key>
  ) {
    guard !isEmpty else { return }
    withValidation { (storage) in
      for key in keys {
        guard let index = storage.index(forKey: key) else {
          continue
        }
        storage.values[index].append(value)
      }
    }
  }

  /// Appends each value in `values` onto any *existing* arrays for each key in `keys`.
  @inlinable
  public mutating func append(
    values: some Collection<Value>,
    forExistingKeys keys: some Sequence<Key>
  ) {
    guard !isEmpty else { return }
    withValidation { (storage) in
      for key in keys {
        guard let index = storage.index(forKey: key) else {
          continue
        }
        storage
          .values[index]
          .append(contentsOf: values)
      }
    }
  }
  
}
