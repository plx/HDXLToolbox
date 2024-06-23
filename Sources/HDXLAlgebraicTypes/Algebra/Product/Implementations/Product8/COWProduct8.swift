import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: COWProduct8
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
public struct COWProduct8<A,B,C,D,E,F,G,H> {
  
  @usableFromInline
  internal typealias Storage = COWBox<InlineProduct8<A,B,C,D,E,F,G,H>>
  
  @usableFromInline
  internal var storage: Storage

  /// "Designated initializer" for `COWProduct8` (pseudo-private).
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }

  /// "Designated initializer" for `COWProduct8` (pseudo-private).
  @inlinable
  internal init?(possibleStorage: Storage?) {
    guard let storage = possibleStorage else {
      return nil
    }
    self.init(storage: storage)
  }

  /// Construct a `COWProduct8` from the individual components.
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H
  ) {
    self.init(
      storage: Storage(
        a,
        b,
        c,
        d,
        e,
        f,
        g,
        h
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension COWProduct8: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable,
F: Sendable,
G: Sendable,
H: Sendable
{ }

extension COWProduct8: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable,
F: Equatable,
G: Equatable,
H: Equatable
{ }

extension COWProduct8: Comparable 
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable,
G: Comparable,
H: Comparable
{ }

extension COWProduct8: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable,
F: Hashable,
G: Hashable,
H: Hashable
{ }

extension COWProduct8: Encodable 
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable,
E: Encodable,
F: Encodable,
G: Encodable,
H: Encodable
{ }

extension COWProduct8: Decodable 
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable,
E: Decodable,
F: Decodable,
G: Decodable,
H: Decodable
{ }

extension COWProduct8: CustomStringConvertible { }
extension COWProduct8: CustomDebugStringConvertible { }

extension COWProduct8: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic,
F: AdditiveArithmetic,
G: AdditiveArithmetic,
H: AdditiveArithmetic
{ }

extension COWProduct8: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic,
F: VectorArithmetic,
G: VectorArithmetic,
H: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension COWProduct8: Identifiable 
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable,
G: Identifiable,
H: Identifiable
{
  public typealias ID = InlineProduct8<
    A.ID,
    B.ID,
    C.ID,
    D.ID,
    E.ID,
    F.ID,
    G.ID,
    H.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct8
// -------------------------------------------------------------------------- //

extension COWProduct8 : AlgebraicProduct8 {
  
  public typealias ArityPosition = Arity8Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { false }

}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension COWProduct8 {
  
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
  
  @inlinable
  public var f: F {
    get {
      storage.f
    }
    set {
      ensureUniqueStorage()
      storage.f = newValue
    }
  }

  @inlinable
  public var g: G {
    get {
      storage.g
    }
    set {
      ensureUniqueStorage()
      storage.g = newValue
    }
  }
  
  @inlinable
  public var h: H {
    get {
      storage.h
    }
    set {
      ensureUniqueStorage()
      storage.h = newValue
    }
  }
  
}
