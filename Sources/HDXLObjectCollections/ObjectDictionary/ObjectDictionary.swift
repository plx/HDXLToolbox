import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// ------------------------------------------------------------------------- //
// MARK: ObjectDictionary
// ------------------------------------------------------------------------- //

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

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension ObjectDictionary: Sendable where Key: Sendable, Value: Sendable { }
extension ObjectDictionary: Equatable where Value: Equatable { }
extension ObjectDictionary: Hashable where Value: Hashable { }
extension ObjectDictionary: Codable where Key: Codable, Value: Codable { }

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionary : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "ObjectDictionary(storage: \(String(describing: storage)))"
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionary : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "ObjectDictionary<\(String(reflecting: Key.self)), \(String(reflecting: Value.self))>(storage: \(String(reflecting: storage)))"
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomReflectable
// ------------------------------------------------------------------------- //

extension ObjectDictionary : CustomReflectable {
  
  @inlinable
  public var customMirror: Mirror {
    // TODO: validate this is useful
    storage.customMirror
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Sequence
// ------------------------------------------------------------------------- //

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

// ------------------------------------------------------------------------- //
// MARK: - Collection
// ------------------------------------------------------------------------- //

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
    storage.distance(
      from: start.index,
      to: end.index
    )
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    Index(
      index: storage.index(
        after: i.index
      )
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

// ------------------------------------------------------------------------- //
// MARK: - Internal API
// ------------------------------------------------------------------------- //

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

// -------------------------------------------------------------------------- //
// MARK: - SingleValueCodable
// -------------------------------------------------------------------------- //

// TODO: implement this via a macro
extension ObjectDictionary : SingleValueCodable where Key: Codable, Value: Codable {
  public typealias SingleValueCodableRepresentation = [ObjectWrapper<Key>: Value]
  
  @inlinable
  public var singleValueCodableRepresentation: SingleValueCodableRepresentation {
    storage
  }
  
  @inlinable
  public init(unsafeFromSingleValueCodableRepresentation singleValueCodableRepresentation: SingleValueCodableRepresentation) throws {
    self.init(storage: singleValueCodableRepresentation)
  }

}

// ------------------------------------------------------------------------- //
// MARK: - Dictionary API
// ------------------------------------------------------------------------- //

extension ObjectDictionary {

  @inlinable
  public var capacity: Int {
    storage.capacity
  }

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
        uniqueKeysWithValues: keysWithValues.onDemandMap {
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
        keysWithValues.onDemandMap {
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
    
  @inlinable
  public subscript(key: Key) -> Value? {
    get {
      storage[ObjectWrapper(object: key)]
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
      storage[
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
    Index(
      possibleIndex: storage.index(
        forKey: ObjectWrapper(object: key)
      )
    )
  }
  
  @inlinable
  public subscript(index: Index) -> Element {
    publicElement(fromStorageElement: storage[index.index])
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
    possiblePublicElement(
      fromPossibleStorageElement: storage.first
    )
  }
  
  @inlinable
  public func randomElement() -> Element? {
    possiblePublicElement(
      fromPossibleStorageElement: storage.randomElement()
    )
  }
  
  @inlinable
  public func randomElement<T>(
    using generator: inout T
  ) -> Element? where T : RandomNumberGenerator {
    possiblePublicElement(
      fromPossibleStorageElement: storage.randomElement(
        using: &generator
      )
    )
  }
  
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
      keysWithValues.onDemandMap {
        (key, value)
        in
        (
          ObjectWrapper(object: key),
          value
        )
      },
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
        keysWithValues.onDemandMap {
          (key, value)
          in
          (
            ObjectWrapper(object: key),
            value
          )
        },
        uniquingKeysWith: combine
      )
    )
  }
  
  @inlinable
  public mutating func reserveCapacity(_ minimumCapacity: Int) {
    storage.reserveCapacity(minimumCapacity)
  }

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
    publicElement(
      fromStorageElement: storage.remove(
        at: index.index
      )
    )
  }
  
  @inlinable
  public mutating func removeAll(keepingCapacity: Bool = false) {
    storage.removeAll(keepingCapacity: keepingCapacity)
  }
  
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
    ObjectDictionary<Key, T>(
      storage: try storage.compactMapValues(transform)
    )
  }

}
