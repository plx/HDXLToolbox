import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray
// -------------------------------------------------------------------------- //

/// A `KeyedArray` is essentially just a dictionary-of-arrays, e.g., it's of the
/// form `[Key:[Value]]`; what makes it useful is that it defines numerous convenience
/// operations for performing bulk/aggregate operations over the entire collection.
///
/// It has a lot in common with its cousin `KeyedSet`, but has a smaller API
/// and doesn't seem to be as broadly-useful as `KeyedSet` has been.
@frozen
public struct KeyedArray<Key, Value> where Key: Hashable {

  /// Shorthand for the type of our backing dictionary.
  @usableFromInline
  internal typealias Storage = [Key:[Value]]
  
  /// The actual "managed" dictionary we're using.
  @usableFromInline
  internal var storage: Storage
  
  // ------------------------------------------------------------------------ //
  // MARK: - Initializers
  // ------------------------------------------------------------------------ //
  
  /// Creates an empty `KeyedArray` (without reserving any capacity).
  @inlinable
  public init() {
    self.init(storage: Storage())
  }
  
  /// Creates an empty `KeyedArray` (reserving the requested `minimumCapacity`).
  @inlinable
  public init(minimumCapacity: Int) {
    pedanticAssert(minimumCapacity >= 0)
    self.init(
      storage: Storage(minimumCapacity: minimumCapacity)
    )
  }
  
  /// Creates a set containing the single assocation `key:[value]`.
  @inlinable
  public init(
    key: Key,
    value: Value
  ) {
    self.init(
      storage: [key: [value]]
    )
  }
  
  /// Creates a set containing the key-value assocations in `keysAndValues`.
  @inlinable
  public init(keysAndValues: [Key:Value]) {
    self.init(
      storage: Storage(
        keysAndValues.onDemandMap { (key, value) in
          (
            key,
            [value]
          )
        },
        uniquingKeysWith: +
      )
    )
  }
  
  /// A de-facto "designated initializer" for a `KeyedArray`; this is private b/c
  /// we can't enforce at the *type-system-level* that `storage` has the no-empty-array
  /// invariant maintained, and so we instead use access control to maintain that.
  @inlinable
  internal init(storage: Storage) {
    pedanticAssert(Self.storageIsValid(storage))
    defer { pedanticAssert(self.isValid) }
    self.storage = storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension KeyedArray: Sendable where Key: Sendable, Value: Sendable { }
extension KeyedArray: Equatable where Value: Equatable { }
extension KeyedArray: Hashable where Value: Hashable { }
extension KeyedArray: Codable where Key: Codable, Value: Codable { }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension KeyedArray: Identifiable where Value: Hashable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension KeyedArray {

  @inlinable
  public var description: String {
    String(describing: storage)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension KeyedArray {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(storage: \(self.storage.debugDescription))"
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: - SingleValueCodable
// -------------------------------------------------------------------------- //

extension KeyedArray: SingleValueCodable where Key: Codable, Value: Codable {
  
  public typealias SingleValueCodableRepresentation = [Key: [Value]]
  
  @inlinable
  public var singleValueCodableRepresentation: SingleValueCodableRepresentation {
    storage
  }

  @inlinable
  public init(unsafeFromSingleValueCodableRepresentation singleValueCodableRepresentation: SingleValueCodableRepresentation) throws {
    guard Self.storageIsValid(singleValueCodableRepresentation) else {
      throw KeyedArrayCodingError.invalidUnderlyingStorage(
        singleValueCodableRepresentation.map { key, values in
          (
            String(reflecting: key),
            values.map { value in
              String(reflecting: values)
            }
          )
        }
      )
    }
    self.init(storage: singleValueCodableRepresentation)
  }
  
  public enum KeyedArrayCodingError: Error {
    case invalidUnderlyingStorage([(String, [String])])
  }
}

// -------------------------------------------------------------------------- //
// MARK: - Validation & Mutation API
// -------------------------------------------------------------------------- //

extension KeyedArray {
  
  @inlinable
  internal static func storageIsValid(_ storage: Storage) -> Bool {
    storage.allSatisfy { _, valueArray in
      !valueArray.isEmpty
    }
  }
  
  /// Returns `true` as long as `self` is correctly maintaining its expected invariants.
  @inlinable
  internal var isValid: Bool {
    Self.storageIsValid(storage)
  }
  
  @inlinable
  internal mutating func withValidation<R>(
    _ closure: (inout Storage) throws -> R
  ) rethrows -> R {
    pedanticAssert(isValid)
    defer { pedanticAssert(isValid) }
    
    return try closure(&storage)
  }
  
}
