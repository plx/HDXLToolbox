import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// ------------------------------------------------------------------------- //
// MARK: KeyedSet
// ------------------------------------------------------------------------- //

@frozen
public struct KeyedSet<Key, Value> where Key: Hashable, Value: Hashable {
  
  public typealias ValueSet = Set<Value>
  
  @usableFromInline
  internal typealias Storage = [Key: ValueSet]
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  internal init() {
    self.init(storage: [:])
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension KeyedSet : Sendable where Key: Sendable, Value: Sendable { }
extension KeyedSet : Equatable { } // Key and Value inherently required to be hashable
extension KeyedSet : Hashable { } // Key and Value inherently required to be hashable
extension KeyedSet : Codable where Key: Codable, Value: Codable { }

// ------------------------------------------------------------------------- //
// MARK: - Identifiable
// ------------------------------------------------------------------------- //

extension KeyedSet: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension KeyedSet : CustomStringConvertible { 
  
  @inlinable
  public var description: String {
    String(describing: storage)
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension KeyedSet : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(storage: \(String(reflecting: storage)))"
  }
}

// ------------------------------------------------------------------------- //
// MARK: - SingleValueCodable
// ------------------------------------------------------------------------- //

extension KeyedSet: SingleValueCodable where Key: Codable, Value: Codable {
  public typealias SingleValueCodableRepresentation = [Key:Set<Value>]
  
  @inlinable
  public var singleValueCodableRepresentation: SingleValueCodableRepresentation {
    storage
  }
  
  @inlinable
  public init(unsafeFromSingleValueCodableRepresentation singleValueCodableRepresentation: SingleValueCodableRepresentation) throws {
    guard Self.storageIsValid(singleValueCodableRepresentation) else {
      throw KeyedSetCodingError.invalidUnderlyingStorage(
        singleValueCodableRepresentation.map { key, values in
          (
            String(reflecting: key),
            values.map { value in String(reflecting: value)}
          )
        }
      )
    }
    self.init(storage: singleValueCodableRepresentation)
  }
  
  public enum KeyedSetCodingError: Error {
    case invalidUnderlyingStorage([(String, [String])])
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Internal API - Validation
// ------------------------------------------------------------------------- //

extension KeyedSet {
  
  @inlinable
  static func storageIsValid(_ storage: Storage) -> Bool {
    storage.allSatisfy { (key, valueSet) in
      !valueSet.isEmpty
    }
  }
  
  @inlinable
  internal var hasConsistentInternalState: Bool {
    Self.storageIsValid(storage)
  }
  
  @inlinable
  internal mutating func withValidation<R>(
    perform closure: (inout Storage) throws -> R
  ) rethrows -> R {
    assert(hasConsistentInternalState)
    defer { assert(hasConsistentInternalState) }
    return try closure(&storage)
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Internal API - Support
// ------------------------------------------------------------------------- //

extension KeyedSet {
  
  @inlinable
  internal var keys: some Collection<Key> {
    storage.keys
  }
  
  @inlinable
  public var keySet: Set<Key> {
    Set(storage.keys)
  }
  
  @inlinable
  internal mutating func resetStorage(keepingCapacity: Bool) {
    storage.removeAll(keepingCapacity: keepingCapacity)
  }
  
}


// ------------------------------------------------------------------------- //
// MARK: - Transform API
// ------------------------------------------------------------------------- //

extension KeyedSet {
  
  @inlinable
  public func mapValues<R>(
  _ transform: (Value) throws -> R
  ) rethrows -> KeyedSet<Key, R> {
    KeyedSet<Key, R>(
      storage: try storage.mapValues { valueSet in
        try valueSet.setMap(transformation: transform)
      }
    )
  }
  
  @inlinable
  public func compactMapValues<R>(
  _ transform: (Value) throws -> R?
  ) rethrows -> KeyedSet<Key, R> {
    var result: [Key: Set<R>] = [:]
    for (key, valueSet) in storage {
      result[key] = try valueSet.nonEmptySetCompactMap(
        transformation: transform
      )
    }
    
    return KeyedSet<Key, R>(
      storage: result
    )
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Collection API
// ------------------------------------------------------------------------- //

extension KeyedSet: Collection {
  
  public typealias Index = KeyedSetIndex<Key, Value>
  public typealias Element = KeyedSetElement<Key, Value>
  
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
    Element(
      element: storage[position.index]
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
      index: storage.index(
        after: i.index
      )
    )
  }
  
  @inlinable
  public func formIndex(after i: inout Index) {
    storage.formIndex(after: &i.index)
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
