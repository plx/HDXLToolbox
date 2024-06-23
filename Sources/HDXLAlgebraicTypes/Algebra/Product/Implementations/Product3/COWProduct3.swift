import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: COWProduct3
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
public struct COWProduct3<A,B,C> {
  
  @usableFromInline
  internal typealias Storage = COWBox<InlineProduct3<A,B,C>>
  
  @usableFromInline
  internal var storage: Storage

  /// "Designated initializer" for `COWProduct3` (pseudo-private).
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }

  /// "Designated initializer" for `COWProduct3` (pseudo-private).
  @inlinable
  internal init?(possibleStorage: Storage?) {
    guard let storage = possibleStorage else {
      return nil
    }
    self.init(storage: storage)
  }

  /// Construct a `COWProduct3` from the individual components.
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C
  ) {
    self.init(
      storage: Storage(
        a,
        b,
        c
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension COWProduct3: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable
{ }

extension COWProduct3: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable
{ }

extension COWProduct3: Comparable 
where
A: Comparable,
B: Comparable,
C: Comparable
{ }

extension COWProduct3: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable
{ }

extension COWProduct3: Encodable 
where
A: Encodable,
B: Encodable,
C: Encodable
{ }

extension COWProduct3: Decodable 
where
A: Decodable,
B: Decodable,
C: Decodable
{ }

extension COWProduct3: CustomStringConvertible { }
extension COWProduct3: CustomDebugStringConvertible { }

extension COWProduct3: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic
{ }

extension COWProduct3: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension COWProduct3: Identifiable 
where
A: Identifiable,
B: Identifiable,
C: Identifiable
{
  public typealias ID = InlineProduct3<
    A.ID,
    B.ID,
    C.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct3
// -------------------------------------------------------------------------- //

extension COWProduct3 : AlgebraicProduct3 {
  
  public typealias ArityPosition = Arity3Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { false }

}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension COWProduct3 {
  
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
      
}
