import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

extension KeyedSet {
  
  /// Does a "join" where each `key` in self winds up associated-with the result
  /// of looking up each of its associated values in `table`; more-efficient than
  /// trying to do the same thing yourself with the more-generic mapping methods.
  @inlinable
  public func joined<T>(
    with table: [Value:T]
  ) -> KeyedSet<Key,T> where T: Hashable {
    guard !isEmpty && !table.isEmpty else {
      return KeyedSet<Key,T>()
    }
    
    var result: KeyedSet<Key,T>.Storage = [:]
    // TODO: evaluate non-default choice of minimum-capacity?
    for (key, valueSet) in storage {
      for value in valueSet {
        guard let destinationValue = table[value] else {
          continue
        }
        
        result[
          key,
          default: []
        ].insert(destinationValue)
      }
    }
    
    return KeyedSet<Key,T>(
      storage: result
    )
  }
  
//  /// Does a "join" where each `key` in self winds up associated-with the result
//  /// of looking up each of its associated values in `table`; more-efficient than
//  /// trying to do the same thing yourself with the more-generic mapping methods.
//  ///
//  /// Only includes keys that "pass" `predicate`.
//  public func joinRestrictedToKeysPassingTest<T:Hashable>(@noescape keyTest predicate: (Key) -> Bool, table: [Value:T]) -> KeyedSet<Key,T> {
//    assert(self.isValid)
//    if self.isEmpty || table.isEmpty {
//      return KeyedSet<Key,T>()
//    } else {
//      var result: [Key:Set<T>] = [Key:Set<T>]()
//      assert(KeyedSet<Key,T>.storageIsValid(result))
//      for (key,valueSet) in self.storage where predicate(key) {
//        assert(KeyedSet<Key,T>.storageIsValid(result))
//        for value in valueSet {
//          assert(KeyedSet<Key,T>.storageIsValid(result))
//          if let farValue = table[value] {
//            if let _ = result[key]?.insert(farValue) {
//            } else {
//              result[key] = [farValue]
//            }
//            assert(KeyedSet<Key,T>.storageIsValid(result))
//          }
//          assert(KeyedSet<Key,T>.storageIsValid(result))
//        }
//        assert(KeyedSet<Key,T>.storageIsValid(result))
//      }
//      assert(KeyedSet<Key,T>.storageIsValid(result))
//      return KeyedSet<Key,T>(storage: result)
//    }
//  }
//  
//  /// Does a "join" where each `key` in self winds up associated-with the result
//  /// of looking up each of its associated values in `table`; more-efficient than
//  /// trying to do the same thing yourself with the more-generic mapping methods.
//  ///
//  /// Only includes keys that "fail" `predicate`.
//  public func joinRestrictedToKeysFailingTest<T:Hashable>(@noescape keyTest predicate: (Key) -> Bool, table: [Value:T]) -> KeyedSet<Key,T> {
//    assert(self.isValid)
//    if self.isEmpty || table.isEmpty {
//      return KeyedSet<Key,T>()
//    } else {
//      var result: [Key:Set<T>] = [Key:Set<T>]()
//      assert(KeyedSet<Key,T>.storageIsValid(result))
//      for (key,valueSet) in self.storage where !predicate(key) {
//        assert(KeyedSet<Key,T>.storageIsValid(result))
//        for value in valueSet {
//          assert(KeyedSet<Key,T>.storageIsValid(result))
//          if let farValue = table[value] {
//            if let _ = result[key]?.insert(farValue) {
//            } else {
//              result[key] = [farValue]
//            }
//            assert(KeyedSet<Key,T>.storageIsValid(result))
//          }
//          assert(KeyedSet<Key,T>.storageIsValid(result))
//        }
//        assert(KeyedSet<Key,T>.storageIsValid(result))
//      }
//      assert(KeyedSet<Key,T>.storageIsValid(result))
//      return KeyedSet<Key,T>(storage: result)
//    }
//  }
//  
//  /// Does a "join" where each `key` in self winds up associated-with the result
//  /// of looking up each of its associated values in `table`; more-efficient than
//  /// trying to do the same thing yourself with the more-generic mapping methods.
//  ///
//  /// Only includes keys in `keys`.
//  public func joinRestrictedToKeys<T:Hashable>(keys: Set<Key>, table: [Value:T]) -> KeyedSet<Key,T> {
//    assert(self.isValid)
//    if self.isEmpty || table.isEmpty || keys.isEmpty {
//      return KeyedSet<Key,T>()
//    } else {
//      var result: [Key:Set<T>] = [Key:Set<T>]()
//      assert(KeyedSet<Key,T>.storageIsValid(result))
//      for (key,valueSet) in self.storage where keys.contains(key) {
//        assert(KeyedSet<Key,T>.storageIsValid(result))
//        for value in valueSet {
//          assert(KeyedSet<Key,T>.storageIsValid(result))
//          if let farValue = table[value] {
//            if let _ = result[key]?.insert(farValue) {
//            } else {
//              result[key] = [farValue]
//            }
//            assert(KeyedSet<Key,T>.storageIsValid(result))
//          }
//          assert(KeyedSet<Key,T>.storageIsValid(result))
//        }
//        assert(KeyedSet<Key,T>.storageIsValid(result))
//      }
//      assert(KeyedSet<Key,T>.storageIsValid(result))
//      return KeyedSet<Key,T>(storage: result)
//    }
//  }
//  
//  /// Does a "join" where each `key` in self winds up associated-with the result
//  /// of looking up each of its associated values in `table`; more-efficient than
//  /// trying to do the same thing yourself with the more-generic mapping methods.
//  ///
//  /// Only includes keys not-in `keys`.
//  public func joinExcludingKeys<T:Hashable>(keys: Set<Key>, table: [Value:T]) -> KeyedSet<Key,T> {
//    assert(self.isValid)
//    if self.isEmpty || table.isEmpty {
//      return KeyedSet<Key,T>()
//    } else if keys.isEmpty {
//      return self.join(table)
//    } else {
//      var result: [Key:Set<T>] = [Key:Set<T>]()
//      assert(KeyedSet<Key,T>.storageIsValid(result))
//      for (key,valueSet) in self.storage where !keys.contains(key) {
//        assert(KeyedSet<Key,T>.storageIsValid(result))
//        for value in valueSet {
//          assert(KeyedSet<Key,T>.storageIsValid(result))
//          if let farValue = table[value] {
//            if let _ = result[key]?.insert(farValue) {
//            } else {
//              result[key] = [farValue]
//            }
//            assert(KeyedSet<Key,T>.storageIsValid(result))
//          }
//          assert(KeyedSet<Key,T>.storageIsValid(result))
//        }
//        assert(KeyedSet<Key,T>.storageIsValid(result))
//      }
//      assert(KeyedSet<Key,T>.storageIsValid(result))
//      return KeyedSet<Key,T>(storage: result)
//    }
//  }
  
}
