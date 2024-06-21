import Foundation

extension KeyedSet {
  
  @inlinable
  public func consolidation<K>(
    by grouping: KeyedSet<K, Key>
  ) -> KeyedSet<K, Value> where K: Hashable {
    var result = KeyedSet<K, Value>.Storage()
    // TODO: update implementation once we have the key-value pairs view
    for (destinationKey, sourceKeySet) in grouping.storage {
      for sourceKey in sourceKeySet {
        result[
          destinationKey,
          default: []
        ].formUnionIfPossible(storage[sourceKey])
      }
    }
    
    return KeyedSet<K, Value>(storage: result)
  }
  
}
