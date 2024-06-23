import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: COWProduct4
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
public struct COWProduct4<A,B,C,D> {
  
  @usableFromInline
  internal typealias Storage = COWBox<InlineProduct4<A,B,C,D>>
  
  @usableFromInline
  internal var storage: Storage

  /// "Designated initializer" for `COWProduct4` (pseudo-private).
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }

  /// "Designated initializer" for `COWProduct4` (pseudo-private).
  @inlinable
  internal init?(possibleStorage: Storage?) {
    guard let storage = possibleStorage else {
      return nil
    }
    self.init(storage: storage)
  }

  /// Construct a `COWProduct4` from the individual components.
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D
  ) {
    self.init(
      storage: Storage(
        a,
        b,
        c,
        d
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension COWProduct4: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable
{ }

extension COWProduct4: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable
{ }

extension COWProduct4: Comparable 
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable
{ }

extension COWProduct4: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable
{ }

extension COWProduct4: Encodable 
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable
{ }

extension COWProduct4: Decodable 
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable
{ }

extension COWProduct4: CustomStringConvertible { }
extension COWProduct4: CustomDebugStringConvertible { }

extension COWProduct4: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic
{ }

extension COWProduct4: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension COWProduct4: Identifiable 
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable
{
  public typealias ID = InlineProduct4<
    A.ID,
    B.ID,
    C.ID,
    D.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct4
// -------------------------------------------------------------------------- //

extension COWProduct4 : AlgebraicProduct4 {
  
  public typealias ArityPosition = Arity4Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { false }

}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension COWProduct4 {
  
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
      
}
