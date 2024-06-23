import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: COWProduct2
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "out-of-line" (e.g. on the heap), implemented
/// as a typical COW-style `struct` wrapper around a `class` that holds the data.
@frozen
public struct COWProduct2<A,B> {
  
  @usableFromInline
  internal typealias Storage = COWBox<InlineProduct2<A,B>>
  
  @usableFromInline
  internal var storage: Storage

  /// "Designated initializer" for `COWProduct2` (pseudo-private).
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
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
      storage: Storage(
        a,
        b
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension COWProduct2: Sendable where A: Sendable, B: Sendable { }
extension COWProduct2: Equatable where A: Equatable, B: Equatable { }
extension COWProduct2: Comparable where A: Comparable, B: Comparable { }
extension COWProduct2: Hashable where A: Hashable, B: Hashable { }
extension COWProduct2: Encodable where A: Encodable, B: Encodable { }
extension COWProduct2: Decodable where A: Decodable, B: Decodable { }
extension COWProduct2: CustomStringConvertible { }
extension COWProduct2: CustomDebugStringConvertible { }

extension COWProduct2: AdditiveArithmetic where A: AdditiveArithmetic, B: AdditiveArithmetic { }
extension COWProduct2: VectorArithmetic where A: VectorArithmetic, B: VectorArithmetic { }

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
      storage.a
    }
    set {
      ensureUniqueStorage()
      storage.a = newValue
    }
  }
  
  @inlinable
  var b: B {
    get {
      storage.b
    }
    set {
      ensureUniqueStorage()
      storage.b = newValue
    }
  }
  
}
