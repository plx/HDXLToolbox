import Foundation
import SwiftUI
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: COWProduct4
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
public struct COWProduct4<A,B,C,D> {
  
  @usableFromInline
  internal typealias Value = InlineProduct4<A,B,C,D>
  
  @usableFromInline
  internal typealias Storage = COWBox<Value>
  
  @usableFromInline
  internal var storage: Storage
  
  /// Forwarding convenience-constructor for underlying value.
  @inlinable
  internal init(value: Value) {
    self.init(
      storage: Storage(value: value)
    )
  }

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
      value: Value(
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
      storage.value.a
    }
    set {
      ensureUniqueStorage()
      storage.value.a = newValue
    }
  }
  
  @inlinable
  public var b: B {
    get {
      storage.value.b
    }
    set {
      ensureUniqueStorage()
      storage.value.b = newValue
    }
  }
  
  @inlinable
  public var c: C {
    get {
      storage.value.c
    }
    set {
      ensureUniqueStorage()
      storage.value.c = newValue
    }
  }
  
  @inlinable
  public var d: D {
    get {
      storage.value.d
    }
    set {
      ensureUniqueStorage()
      storage.value.d = newValue
    }
  }
      
}
