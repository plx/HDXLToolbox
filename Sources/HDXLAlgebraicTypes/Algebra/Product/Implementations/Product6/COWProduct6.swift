import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: COWProduct6
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
public struct COWProduct6<A,B,C,D,E,F> {
  
  @usableFromInline
  internal typealias Value = InlineProduct6<A,B,C,D,E,F>
  
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
      value: Value(
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

extension COWProduct6: CustomStringConvertible { }
extension COWProduct6: CustomDebugStringConvertible { }

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
  
}
