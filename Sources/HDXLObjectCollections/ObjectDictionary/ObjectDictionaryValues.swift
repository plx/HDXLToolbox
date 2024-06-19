import Foundation

@frozen
public struct ObjectDictionaryValues<Key, Value> where Key: AnyObject {
  
  @usableFromInline
  internal typealias Storage = Dictionary<ObjectWrapper<Key>, Value>.Values
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
}

extension ObjectDictionaryValues: Sendable where Key: Sendable, Value: Sendable { }

extension ObjectDictionaryValues: Sequence {
  public typealias Iterator = ObjectDictionaryValuesIterator<Key, Value>
  
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

extension ObjectDictionaryValues: MutableCollection {
  
  public typealias Index = ObjectDictionaryValuesIndex<Key, Value>
  
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
    get {
      storage[position.index]
    }
    set {
      storage[position.index] = newValue
    }
  }
  
  @inlinable
  public mutating func swapAt(
    _ i: Index,
    _ j: Index
  ) {
    storage.swapAt(
      i.index,
      j.index
    )
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

extension ObjectDictionaryValues: CustomStringConvertible {
  @inlinable
  public var description: String {
    "ObjectDictionaryValues(storage: \(String(describing: storage)))"
  }
}

extension ObjectDictionaryValues: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    "ObjectDictionaryValues<\(String(reflecting: Key.self)), \(String(reflecting: Value.self))>(storage: \(String(reflecting: storage)))"
  }
}
