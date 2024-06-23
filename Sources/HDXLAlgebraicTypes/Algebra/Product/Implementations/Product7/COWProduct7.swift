import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: COWProduct7
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
public struct COWProduct7<A,B,C,D,E,F,G> {
  
  @usableFromInline
  internal typealias Storage = COWBox<InlineProduct7<A,B,C,D,E,F,G>>
  
  @usableFromInline
  internal var storage: Storage

  /// "Designated initializer" for `COWProduct7` (pseudo-private).
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }

  /// "Designated initializer" for `COWProduct7` (pseudo-private).
  @inlinable
  internal init?(possibleStorage: Storage?) {
    guard let storage = possibleStorage else {
      return nil
    }
    self.init(storage: storage)
  }

  /// Construct a `COWProduct7` from the individual components.
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G
  ) {
    self.init(
      storage: Storage(
        a,
        b,
        c,
        d,
        e,
        f,
        g
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension COWProduct7: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable,
F: Sendable,
G: Sendable
{ }

extension COWProduct7: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable,
F: Equatable,
G: Equatable
{ }

extension COWProduct7: Comparable 
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable,
G: Comparable
{ }

extension COWProduct7: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable,
F: Hashable,
G: Hashable
{ }

extension COWProduct7: Encodable 
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable,
E: Encodable,
F: Encodable,
G: Encodable
{ }

extension COWProduct7: Decodable 
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable,
E: Decodable,
F: Decodable,
G: Decodable
{ }

extension COWProduct7: CustomStringConvertible { }
extension COWProduct7: CustomDebugStringConvertible { }

extension COWProduct7: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic,
F: AdditiveArithmetic,
G: AdditiveArithmetic
{ }

extension COWProduct7: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic,
F: VectorArithmetic,
G: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension COWProduct7: Identifiable 
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable,
G: Identifiable
{
  public typealias ID = InlineProduct7<
    A.ID,
    B.ID,
    C.ID,
    D.ID,
    E.ID,
    F.ID,
    G.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct7
// -------------------------------------------------------------------------- //

extension COWProduct7 : AlgebraicProduct7 {
  
  public typealias ArityPosition = Arity7Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { false }

}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension COWProduct7 {
  
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
  
}
