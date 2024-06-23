import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: COWProduct9
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
public struct COWProduct9<A,B,C,D,E,F,G,H,I> {
  
  @usableFromInline
  internal typealias Storage = COWBox<InlineProduct9<A,B,C,D,E,F,G,H,I>>
  
  @usableFromInline
  internal var storage: Storage

  /// "Designated initializer" for `COWProduct9` (pseudo-private).
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }

  /// "Designated initializer" for `COWProduct9` (pseudo-private).
  @inlinable
  internal init?(possibleStorage: Storage?) {
    guard let storage = possibleStorage else {
      return nil
    }
    self.init(storage: storage)
  }

  /// Construct a `COWProduct9` from the individual components.
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I
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
        h,
        i
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension COWProduct9: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable,
F: Sendable,
G: Sendable,
H: Sendable,
I: Sendable
{ }

extension COWProduct9: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable,
F: Equatable,
G: Equatable,
H: Equatable,
I: Equatable
{ }

extension COWProduct9: Comparable 
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable,
G: Comparable,
H: Comparable,
I: Comparable
{ }

extension COWProduct9: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable,
F: Hashable,
G: Hashable,
H: Hashable,
I: Hashable
{ }

extension COWProduct9: Encodable 
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable,
E: Encodable,
F: Encodable,
G: Encodable,
H: Encodable,
I: Encodable
{ }

extension COWProduct9: Decodable 
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable,
E: Decodable,
F: Decodable,
G: Decodable,
H: Decodable,
I: Decodable
{ }

extension COWProduct9: CustomStringConvertible { }
extension COWProduct9: CustomDebugStringConvertible { }

extension COWProduct9: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic,
F: AdditiveArithmetic,
G: AdditiveArithmetic,
H: AdditiveArithmetic,
I: AdditiveArithmetic
{ }

extension COWProduct9: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic,
F: VectorArithmetic,
G: VectorArithmetic,
H: VectorArithmetic,
I: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension COWProduct9: Identifiable 
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable,
G: Identifiable,
H: Identifiable,
I: Identifiable

{
  public typealias ID = InlineProduct9<
    A.ID,
    B.ID,
    C.ID,
    D.ID,
    E.ID,
    F.ID,
    G.ID,
    H.ID,
    I.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct9
// -------------------------------------------------------------------------- //

extension COWProduct9 : AlgebraicProduct9 {
  
  public typealias ArityPosition = Arity9Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { false }

}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension COWProduct9 {
  
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
  
  @inlinable
  public var i: I {
    get {
      storage.i
    }
    set {
      ensureUniqueStorage()
      storage.i = newValue
    }
  }

}
