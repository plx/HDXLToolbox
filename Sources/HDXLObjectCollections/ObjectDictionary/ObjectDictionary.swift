import Foundation

@frozen
public struct ObjectDictionary<Key, Value> where Key: AnyObject {
  
  public typealias Element = (key: Key, value: Value)
  public typealias Index = ObjectDictionaryIndex<Key, Value>
  public typealias Iterator = ObjectDictionaryIterator<Key, Value>
  public typealias Keys = ObjectDictionaryKeys<Key, Value>
  public typealias Values = ObjectDictionaryValues<Key, Value>
  
  @usableFromInline
  internal typealias Storage = Dictionary<ObjectWrapper<Key>, Value>
  
  @usableFromInline
  internal typealias StorageElement = Storage.Element
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
}

extension ObjectDictionary: Sendable where Key: Sendable, Value: Sendable { }
extension ObjectDictionary: Equatable where Value: Equatable { }
extension ObjectDictionary: Hashable where Value: Hashable { }
extension ObjectDictionary: Codable where Key: Codable, Value: Codable { }

extension ObjectDictionary {
  
  @inlinable
  internal func publicElement(fromStorageElement storageElement: StorageElement) -> Element {
    return (
      key: storageElement.key.object,
      value: storageElement.value
    )
  }
  
  @inlinable
  internal func storageElement(fromPublicElement publicElement: Element) -> StorageElement {
    return (
      key: ObjectWrapper(object: publicElement.key),
      value: publicElement.value
    )
  }
  
  @inlinable
  internal func possiblePublicElement(fromPossibleStorageElement possibleStorageElement: StorageElement?) -> Element? {
    guard let storageElement = possibleStorageElement else {
      return nil
    }
    return publicElement(fromStorageElement: storageElement)
  }
  
  @inlinable
  internal func possibleStorageElement(fromPossiblePublicElement possiblePublicElement: Element?) -> StorageElement? {
    guard let publicElement = possiblePublicElement else {
      return nil
    }
    return storageElement(fromPublicElement: publicElement)
  }
  
}

extension ObjectDictionary {
  
  @inlinable
  public init() {
    self.init(storage: Storage())
  }
  
  @inlinable
  public init(minimumCapacity: Int) {
    self.init(storage: Storage(minimumCapacity: minimumCapacity))
  }
  
  @inlinable
  public init(uniqueKeysWithValues keysWithValues: some Sequence<(Key, Value)>) {
    self.init(
      storage: Storage(
        uniqueKeysWithValues: keysWithValues.lazy.map {
          (object, value)
          in
          (ObjectWrapper(object: object), value)
        }
      )
    )
  }
  
  @inlinable
  public init(
    _ keysWithValues: some Sequence<(Key, Value)>,
    uniquingKeysWith combine: (Value, Value) throws -> Value
  ) rethrows {
    self.init(
      storage: try Storage(
        keysWithValues
          .lazy
          .map {
            (object, value)
            in
            (ObjectWrapper(object: object), value)
          },
        uniquingKeysWith: combine
      )
    )
  }
  
  @inlinable
  public init<S>(
    grouping values: S,
    by keyForValue: (S.Element) throws -> Key
  ) rethrows where S: Sequence, Value == [S.Element] {
    self.init(
      storage: try Storage(grouping: values) {
        value
        in
        ObjectWrapper(object: try keyForValue(value))
      }
    )
  }
  
}

extension ObjectDictionary {
  
  @inlinable
  public var capacity: Int {
    storage.capacity
  }
  
}

extension ObjectDictionary {
  
  @inlinable
  public subscript(key: Key) -> Value? {
    get {
      return storage[ObjectWrapper(object: key)]
    }
    set {
      storage[ObjectWrapper(object: key)] = newValue
    }
  }
  
  @inlinable
  public subscript(
    key: Key,
    default defaultValue: @autoclosure () -> Value
  ) -> Value {
    get {
      return storage[
        ObjectWrapper(object: key),
        default: defaultValue()
      ]
    }
    set {
      storage[
        ObjectWrapper(object: key),
        default: defaultValue()
      ] = newValue
    }
  }
  
  @inlinable
  public func index(forKey key: Key) -> Index? {
    return Index(
      possibleIndex: storage.index(
        forKey: ObjectWrapper(object: key)
      )
    )
  }
  
  @inlinable
  public subscript(index: Index) -> Element {
    return publicElement(fromStorageElement: storage[index.index])
  }
  
  @inlinable
  public var keys: Keys {
    Keys(storage: storage.keys)
  }
  
  @inlinable
  public var values: Values {
    Values(storage: storage.values)
  }
  
  @inlinable
  public var first: Element? {
    return possiblePublicElement(
      fromPossibleStorageElement: storage.first
    )
  }
  
  @inlinable
  public func randomElement() -> Element? {
    return possiblePublicElement(
      fromPossibleStorageElement: storage.randomElement()
    )
  }
  
  @inlinable
  public func randomElement<T>(
    using generator: inout T
  ) -> Element? where T : RandomNumberGenerator {
    return possiblePublicElement(
      fromPossibleStorageElement: storage.randomElement(
        using: &generator
      )
    )
  }
  
}

extension ObjectDictionary {
  
  @inlinable
  public mutating func updateValue(
    _ value: Value,
    forKey key: Key
  ) -> Value? {
    storage.updateValue(
      value,
      forKey: ObjectWrapper(object: key)
    )
  }
  
  @inlinable
  public mutating func merge(
    _ objectDictionary: ObjectDictionary<Key, Value>,
    uniquingKeysWith combine: (Value, Value) throws -> Value
  ) rethrows {
    try storage.merge(
      objectDictionary.storage,
      uniquingKeysWith: combine
    )
  }
  
  @inlinable
  public mutating func merge(
    _ keysWithValues: some Sequence<(Key, Value)>,
    uniquingKeysWith combine: (Value, Value) throws -> Value
  ) rethrows {
    try storage.merge(
      keysWithValues
        .lazy
        .map {
          (key, value)
          in
          (
            ObjectWrapper(object: key),
            value
          )
        }
      ,
      uniquingKeysWith: combine
    )
  }
  
  @inlinable
  public func merging(
    _ objectDictionary: ObjectDictionary<Key, Value>,
    uniquingKeysWith combine: (Value, Value) throws -> Value
  ) rethrows -> ObjectDictionary<Key, Value> {
    ObjectDictionary<Key, Value>(
      storage: try storage.merging(
        objectDictionary.storage,
        uniquingKeysWith: combine
      )
    )
  }

  @inlinable
  public func merging(
    _ keysWithValues: some Sequence<(Key, Value)>,
    uniquingKeysWith combine: (Value, Value) throws -> Value
  ) rethrows -> ObjectDictionary<Key, Value> {
    ObjectDictionary<Key, Value>(
      storage: try storage.merging(
        keysWithValues
          .lazy
          .map {
            (key, value)
            in
            (
              ObjectWrapper(object: key),
              value
            )
          }
        ,
        uniquingKeysWith: combine
      )
    )
  }
  
  @inlinable
  public mutating func reserveCapacity(_ minimumCapacity: Int) {
    storage.reserveCapacity(minimumCapacity)
  }

}

extension ObjectDictionary {
  
  @inlinable
  public func filter(
    _ predicate: (Element) throws -> Bool
  ) rethrows -> ObjectDictionary<Key, Value> {
    ObjectDictionary<Key, Value>(
      storage: try storage.filter {
        (key, value)
        in
        try predicate((
          key: key.object,
          value: value
        ))
      }
    )
  }
  
  @inlinable
  public mutating func removeValue(forKey key: Key) -> Value? {
    storage.removeValue(
      forKey: ObjectWrapper(object: key)
    )
  }
  
  @inlinable
  public mutating func remove(at index: Index) -> Element {
    return publicElement(
      fromStorageElement: storage.remove(
        at: index.index
      )
    )
  }
  
  @inlinable
  public mutating func removeAll(keepingCapacity: Bool = false) {
    storage.removeAll(keepingCapacity: keepingCapacity)
  }
  
}

extension ObjectDictionary {

  @inlinable
  public func mapValues<T>(
    _ transform: (Value) throws -> T
  ) rethrows -> ObjectDictionary<Key, T> {
    return ObjectDictionary<Key, T>(
      storage: try storage.mapValues(transform)
    )
  }

  @inlinable
  public func compactMapValues<T>(
    _ transform: (Value) throws -> T?
  ) rethrows -> ObjectDictionary<Key, T> {
    return ObjectDictionary<Key, T>(
      storage: try storage.compactMapValues(transform)
    )
  }

}

extension ObjectDictionary : Sequence {
  
  @inlinable
  public var underestimatedCount: Int {
    storage.underestimatedCount
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(iterator: storage.makeIterator())
  }
}

extension ObjectDictionary : Collection {

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

extension ObjectDictionary : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    return "ObjectDictionary(storage: \(String(describing: storage)))"
  }
  
}

extension ObjectDictionary : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    return "ObjectDictionary<\(String(reflecting: Key.self)), \(String(reflecting: Value.self))>(storage: \(String(reflecting: storage)))"
  }
  
}
