import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: COWProduct8
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyAdditiveArithmetic
@ConditionallyVectorArithmetic
public struct COWProduct8<A,B,C,D,E,F,G,H> {
  
  @usableFromInline
  internal typealias Value = InlineProduct8<A,B,C,D,E,F,G,H>
  
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
      value: Value(
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

extension COWProduct8: CustomStringConvertible { }
extension COWProduct8: CustomDebugStringConvertible { }

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
  
  @inlinable
  public var e: E {
    get {
      storage.value.e
    }
    set {
      ensureUniqueStorage()
      storage.value.e = newValue
    }
  }
  
  @inlinable
  public var f: F {
    get {
      storage.value.f
    }
    set {
      ensureUniqueStorage()
      storage.value.f = newValue
    }
  }

  @inlinable
  public var g: G {
    get {
      storage.value.g
    }
    set {
      ensureUniqueStorage()
      storage.value.g = newValue
    }
  }
  
  @inlinable
  public var h: H {
    get {
      storage.value.h
    }
    set {
      ensureUniqueStorage()
      storage.value.h = newValue
    }
  }
  
}
