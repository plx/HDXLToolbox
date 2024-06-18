import Foundation

@frozen
public struct ObjectDictionaryKeys<Key, Value> where Key: AnyObject {
  
  @usableFromInline
  internal typealias Storage = Dictionary<ObjectWrapper<Key>, Value>.Keys
  
  @usableFromInline
  internal let storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
}

extension ObjectDictionaryKeys: Sendable where Key: Sendable, Value: Sendable { }
extension ObjectDictionaryKeys: Equatable where Value: Equatable { }

extension ObjectDictionaryKeys: Sequence {
  public typealias Iterator = ObjectDictionaryKeysIterator<Key, Value>
  
  @inlinable
  public var underestimatedCount: Int {
    storage.underestimatedCount
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    return Iterator(
      iterator: storage.makeIterator()
    )
  }
}

extension ObjectDictionaryKeys: Collection {
  
  public typealias Index = ObjectDictionaryKeysIndex<Key, Value>
  
  @inlinable
  public var isEmpty: Bool {
    storage.isEmpty
  }
  
  @inlinable
  public var count: Int {
    storage.count
  }
  
  @inlinable
  public var startIndex: Index {
    Index(index: storage.startIndex)
  }
  
  @inlinable
  public var endIndex: Index {
    Index(index: storage.endIndex)
  }
  
  @inlinable
  public subscript(position: Index) -> Element {
    return storage[position.index].object
  }
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index
  ) -> Int {
    return storage.distance(
      from: start.index,
      to: end.index
    )
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    return Index(
      index: storage.index(after: i.index)
    )
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int
  ) -> Index {
    return Index(
      index: storage.index(
        i.index,
        offsetBy: distance
      )
    )
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int,
    limitedBy limit: Index
  ) -> Index? {
    return Index(
      possibleIndex: storage.index(
        i.index,
        offsetBy: distance,
        limitedBy: limit.index
      )
    )
  }
  
  @inlinable
  public func formIndex(after i: inout Index) {
    storage.formIndex(after: &i.index)
  }

  @inlinable
  public func formIndex(
    _ i: inout Index,
    offsetBy distance: Int
  ) {
    storage.formIndex(
      &i.index,
      offsetBy: distance
    )
  }

  @inlinable
  public func formIndex(
    _ i: inout Index,
    offsetBy distance: Int,
    limitedBy limit: Index
  ) -> Bool {
    storage.formIndex(
      &i.index,
      offsetBy: distance,
      limitedBy: limit.index
    )
  }

}

extension ObjectDictionaryKeys: CustomStringConvertible {
  @inlinable
  public var description: String {
    "ObjectDictionaryKeys(storage: \(String(describing: storage)))"
  }
}

extension ObjectDictionaryKeys: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    "ObjectDictionaryKeys<\(String(reflecting: Key.self)), \(String(reflecting: Value.self))>(storage: \(String(reflecting: storage)))"
  }
}
