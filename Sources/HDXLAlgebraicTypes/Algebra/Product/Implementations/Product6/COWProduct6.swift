import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: COWProduct6
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
public struct COWProduct6<A,B,C,D,E,F> {
  
  @usableFromInline
  internal typealias Storage = COWBox<InlineProduct6<A,B,C,D,E,F>>
  
  @usableFromInline
  internal var storage: Storage

  /// "Designated initializer" for `COWProduct6` (pseudo-private).
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }

  /// "Designated initializer" for `COWProduct6` (pseudo-private).
  @inlinable
  internal init?(possibleStorage: Storage?) {
    guard let storage = possibleStorage else {
      return nil
    }
    self.init(storage: storage)
  }

  /// Construct a `COWProduct6` from the individual components.
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F
  ) {
    self.init(
      storage: Storage(
        a,
        b,
        c,
        d,
        e,
        f
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension COWProduct6: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable,
F: Sendable
{ }

extension COWProduct6: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable,
F: Equatable
{ }

extension COWProduct6: Comparable 
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable
{ }

extension COWProduct6: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable,
F: Hashable
{ }

extension COWProduct6: Encodable 
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable,
E: Encodable,
F: Encodable
{ }

extension COWProduct6: Decodable 
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable,
E: Decodable,
F: Decodable
{ }

extension COWProduct6: CustomStringConvertible { }
extension COWProduct6: CustomDebugStringConvertible { }

extension COWProduct6: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic,
F: AdditiveArithmetic
{ }

extension COWProduct6: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic,
F: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension COWProduct6: Identifiable 
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable
{
  public typealias ID = InlineProduct6<
    A.ID,
    B.ID,
    C.ID,
    D.ID,
    E.ID,
    F.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct6
// -------------------------------------------------------------------------- //

extension COWProduct6 : AlgebraicProduct6 {
  
  public typealias ArityPosition = Arity6Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { false }

}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension COWProduct6 {
  
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
  
}
