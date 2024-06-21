import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Adding Elements
// -------------------------------------------------------------------------- //

extension KeyedArray {

  // -------------------------------------------------------------------------- //
  // MARK: Prepending Single Elements
  // -------------------------------------------------------------------------- //

  /// Prepends `value` into the array associated-with `key`.
  @inlinable
  public mutating func prepend(
    value: Value,
    forKey key: Key
  ) {
    withValidation { storage in
      storage[
        key,
        default: []
      ].insert(value, at: 0)
    }
  }
  
  /// Prepends `value` into the arrays associated-with each key in `keys`.
  @inlinable
  public mutating func prepend(
    value: Value,
    forKeys keys: some Sequence<Key>
  ) {
    withValidation { storage in
      for key in keys {
        storage[
          key,
          default: []
        ].insert(value, at: 0)
      }
    }
  }

  /// Prepends `value` into the arrays associated-with each key in `keys`.
  @inlinable
  public mutating func prepend(
    value: Value,
    forKeys keys: some Collection<Key>
  ) {
    guard !keys.isEmpty else { return }
    withValidation { storage in
      for key in keys {
        storage[
          key,
          default: []
        ].insert(value, at: 0)
      }
    }
  }

  // -------------------------------------------------------------------------- //
  // MARK: Prepending Multiple Elements
  // -------------------------------------------------------------------------- //

  /// Prepends each value in `values` into the array associated-with `key`.
  @inlinable
  public mutating func prepend(
    values: some Collection<Value>,
    forKey key: Key
  ) {
    guard !values.isEmpty else { return }
    withValidation { storage in
      storage[
        key,
        default: []
      ].insert(
        contentsOf: values,
        at: 0
      )
    }
  }

  /// Prepends `value` into the arrays associated-with each key in `keys`.
  @inlinable
  public mutating func prepend(
    values: some Collection<Value>,
    forKeys keys: some Sequence<Key>
  ) {
    guard !values.isEmpty else { return }
    withValidation { storage in
      for key in keys {
        storage[
          key,
          default: []
        ].insert(
          contentsOf: values,
          at: 0
        )
      }
    }
  }
  
  /// Prepends `value` into the arrays associated-with each key in `keys`.
  @inlinable
  public mutating func prepend(
    values: some Collection<Value>,
    forKeys keys: some Collection<Key>
  ) {
    guard !values.isEmpty && !keys.isEmpty else { return }
    withValidation { storage in
      for key in keys {
        storage[
          key,
          default: []
        ].insert(
          contentsOf: values,
          at: 0
        )
      }
    }
  }

  // -------------------------------------------------------------------------- //
  // MARK: Appending Single Elements
  // -------------------------------------------------------------------------- //

  /// Appends `value` into the array associated-with `key`.
  @inlinable
  public mutating func append(
    value: Value,
    forKey key: Key
  ) {
    withValidation { storage in
      storage[
        key,
        default: []
      ].append(value)
    }
  }
  
  /// Appends `value` into the arrays associated-with each key in `keys`.
  @inlinable
  public mutating func append(
    value: Value,
    forKeys keys: some Sequence<Key>
  ) {
    withValidation { storage in
      for key in keys {
        storage[
          key,
          default: []
        ].append(value)
      }
    }
  }
  
  /// Appends `value` into the arrays associated-with each key in `keys`.
  @inlinable
  public mutating func append(
    value: Value,
    forKeys keys: some Collection<Key>
  ) {
    guard !keys.isEmpty else { return }
    withValidation { storage in
      for key in keys {
        storage[
          key,
          default: []
        ].append(value)
      }
    }
  }
  
  // -------------------------------------------------------------------------- //
  // MARK: Appending Multiple Elements
  // -------------------------------------------------------------------------- //

  /// Appends each value in `values` into the array associated-with `key`.
  @inlinable
  public mutating func append(
    values: some Sequence<Value>,
    forKey key: Key
  ) {
    withValidation { storage in
      storage[
        key,
        default: []
      ].append(
        contentsOf: values
      )
    }
  }
  
  /// Appends each value in `values` into the array associated-with `key`.
  @inlinable
  public mutating func append(
    values: some Collection<Value>,
    forKey key: Key
  ) {
    guard !values.isEmpty else { return }
    withValidation { storage in
      storage[
        key,
        default: []
      ].append(
        contentsOf: values
      )
    }
  }
  
  /// Appends `value` into the arrays associated-with each key in `keys`.
  @inlinable
  public mutating func append(
    values: some Collection<Value>,
    forKeys keys: some Sequence<Key>
  ) {
    guard !values.isEmpty else { return }
    withValidation { storage in
      for key in keys {
        storage[
          key,
          default: []
        ].append(
          contentsOf: values
        )
      }
    }
  }
  
  /// Appends `value` into the arrays associated-with each key in `keys`.
  @inlinable
  public mutating func append(
    values: some Collection<Value>,
    forKeys keys: some Collection<Key>
  ) {
    guard !values.isEmpty && !keys.isEmpty else { return }
    withValidation { storage in
      for key in keys {
        storage[
          key,
          default: []
        ].append(
          contentsOf: values
        )
      }
    }
  }

}
