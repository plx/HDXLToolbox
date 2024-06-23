import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: COWProduct2
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
public struct COWProduct2<A,B> {
  
  @usableFromInline
  internal typealias Value = InlineProduct2<A,B>
  
  @usableFromInline
  internal typealias Storage = COWBox<Value>

  @usableFromInline
  internal var storage: Storage

  /// "Designated initializer" for `COWProduct2` (pseudo-private).
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }

  /// Forwarding convenience-constructor for underlying value.
  @inlinable
  internal init(value: Value) {
    self.init(
      storage: Storage(value: value)
    )
  }

  /// "Designated initializer" for `COWProduct2` (pseudo-private).
  @inlinable
  internal init?(possibleStorage: Storage?) {
    guard let storage = possibleStorage else {
      return nil
    }
    self.init(storage: storage)
  }

  /// Construct a `COWProduct2` from the individual components.
  @inlinable
  public init(
    _ a: A,
    _ b: B
  ) {
    self.init(
      value: Value(        
        a,
        b
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension COWProduct2: CustomStringConvertible { }
extension COWProduct2: CustomDebugStringConvertible { }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension COWProduct2: Identifiable where A: Identifiable, B: Identifiable {
  public typealias ID = InlineProduct2<A.ID, B.ID>
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct2
// -------------------------------------------------------------------------- //

extension COWProduct2 : AlgebraicProduct2 {
  
  public typealias ArityPosition = Arity2Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { false }

}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension COWProduct2 {
  
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
  
}
