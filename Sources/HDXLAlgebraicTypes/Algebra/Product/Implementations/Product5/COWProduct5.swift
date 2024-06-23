import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: COWProduct5
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
public struct COWProduct5<A,B,C,D,E> {
  
  @usableFromInline
  internal typealias Storage = COWBox<InlineProduct5<A,B,C,D,E>>
  
  @usableFromInline
  internal var storage: Storage

  /// "Designated initializer" for `COWProduct5` (pseudo-private).
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }

  /// "Designated initializer" for `COWProduct5` (pseudo-private).
  @inlinable
  internal init?(possibleStorage: Storage?) {
    guard let storage = possibleStorage else {
      return nil
    }
    self.init(storage: storage)
  }

  /// Construct a `COWProduct5` from the individual components.
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E
  ) {
    self.init(
      storage: Storage(
        a,
        b,
        c,
        d,
        e
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension COWProduct5: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable
{ }

extension COWProduct5: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable
{ }

extension COWProduct5: Comparable 
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable
{ }

extension COWProduct5: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable
{ }

extension COWProduct5: Encodable 
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable,
E: Encodable
{ }

extension COWProduct5: Decodable 
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable,
E: Decodable
{ }

extension COWProduct5: CustomStringConvertible { }
extension COWProduct5: CustomDebugStringConvertible { }

extension COWProduct5: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic
{ }

extension COWProduct5: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension COWProduct5: Identifiable 
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable
{
  public typealias ID = InlineProduct5<
    A.ID,
    B.ID,
    C.ID,
    D.ID,
    E.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct5
// -------------------------------------------------------------------------- //

extension COWProduct5 : AlgebraicProduct5 {
  
  public typealias ArityPosition = Arity5Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { false }

}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension COWProduct5 {
  
  @inlinable
  internal mutating func ensureUniqueStorage() {
    guard !isKnownUniquelyReferenced(&storage) else {
      return
    }
    
    storage = storage.obtainClone()
  }
  
  @inlinable
  public var a: A {
    get {
      storage.a
    }
    set {
      ensureUniqueStorage()
      storage.a = newValue
    }
  }
  
  @inlinable
  public var b: B {
    get {
      storage.b
    }
    set {
      ensureUniqueStorage()
      storage.b = newValue
    }
  }
  
  @inlinable
  public var c: C {
    get {
      storage.c
    }
    set {
      ensureUniqueStorage()
      storage.c = newValue
    }
  }
  
  @inlinable
  public var d: D {
    get {
      storage.d
    }
    set {
      ensureUniqueStorage()
      storage.d = newValue
    }
  }
  
  @inlinable
  public var e: E {
    get {
      storage.e
    }
    set {
      ensureUniqueStorage()
      storage.e = newValue
    }
  }
    
}
