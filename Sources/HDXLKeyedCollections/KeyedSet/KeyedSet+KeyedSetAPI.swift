import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

extension KeyedSet {
  
  @inlinable
  public subscript(key: Key) -> Set<Value>? {
    get {
      storage[key]
    }
    set {
      withValidation {
        (storage)
        in
        switch newValue {
        case .some(let possiblyEmptySet):
          switch possiblyEmptySet.isEmpty {
          case true:
            storage.removeValue(forKey: key)
          case false:
            storage[key] = newValue
          }
        case .none:
          storage.removeValue(forKey: key)
        }
      }
    }
  }
  
  @inlinable
  public func contains(
    value: Value,
    forKey key: Key
  ) -> Bool {
    storage[key]?.contains(value) ?? false
  }
  
  @inlinable
  public func contains(
    values: Set<Value>,
    forKey key: Key
  ) -> Bool {
    guard !values.isEmpty else { return true }
    
    return storage[key]?.isSuperset(of: values) ?? false
  }
  
  @inlinable
  public func hasValues(forKey key: Key) -> Bool {
    storage[key] != nil
  }
  
  @inlinable
  public func hasValues(forKeys keys: Set<Key>) -> Bool {
    keys.allSatisfy(hasValues(forKey:))
  }
  
  @inlinable
  public func hasValues(forKeys keys: some Sequence<Key>) -> Bool {
    keys.allSatisfy(hasValues(forKey:))
  }
  
  @inlinable
  public func keys(forValue value: Value) -> some Sequence<Key> {
    storage.keysForValuesSatisfying { valueSet in valueSet.contains(value) }
  }
  
  @inlinable
  public func keySet(forValue value: Value) -> Set<Key> {
    Set(keys(forValue: value))
  }

  @inlinable
  public func keys(forValues values: Set<Value>) -> some Sequence<Key> {
    storage.keysForValuesSatisfying { valueSet in !valueSet.isDisjoint(with: values) }
  }

  @inlinable
  public func keys(forValues values: some Sequence<Value>) -> some Sequence<Key> {
    keys(forValues: Set(values))
  }

  @inlinable
  public func keySet(forValues values: Set<Value>) -> Set<Key> {
    Set(keys(forValues: values))
  }

  @inlinable
  public func keySet(forValues values: some Sequence<Value>) -> Set<Key> {
    Set(keys(forValues: values))
  }

}
