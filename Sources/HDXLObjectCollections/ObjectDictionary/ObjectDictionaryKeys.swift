import Foundation

// ------------------------------------------------------------------------- //
// MARK: ObjectDictionaryKeys
// ------------------------------------------------------------------------- //

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

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension ObjectDictionaryKeys: Sendable where Key: Sendable, Value: Sendable { }
extension ObjectDictionaryKeys: Equatable where Value: Equatable { }

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionaryKeys: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "ObjectDictionaryKeys(storage: \(String(describing: storage)))"
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionaryKeys: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(storage: \(String(reflecting: storage)))"
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Sequence
// ------------------------------------------------------------------------- //

extension ObjectDictionaryKeys: Sequence {
  public typealias Iterator = ObjectDictionaryKeysIterator<Key, Value>
  
  @inlinable
  public var underestimatedCount: Int {
    storage.underestimatedCount
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(
      iterator: storage.makeIterator()
    )
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Collection
// ------------------------------------------------------------------------- //

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
    storage[position.index].object
  }
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index
  ) -> Int {
    storage.distance(
      from: start.index,
      to: end.index
    )
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    Index(
      index: storage.index(after: i.index)
    )
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int
  ) -> Index {
    Index(
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
    Index(
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
