import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex
// -------------------------------------------------------------------------- //

@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyEncodable
@ConditionallyDecodable
@StorageComparable
@StorageCustomStringConvertible
@StorageCustomDebugStringConvertible
public struct Chain9CollectionIndex<A,B,C,D,E,F,G,H,I>
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
{
  
  @usableFromInline
  internal typealias Position = Sum9<A,B,C,D,E,F,G,H,I>
  
  @usableFromInline
  internal typealias Storage = PositionIndexStorage<Position>

  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  internal init(position: Position) {
    self.init(
      storage: .position(position)
    )
  }
  
  @inlinable
  internal static var endIndex: Self {
    Self(storage: .endIndex)
  }
}

// -------------------------------------------------------------------------- //
// MARK: - CaseIterable
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex: CaseIterable 
where
A: CaseIterable,
B: CaseIterable,
C: CaseIterable,
D: CaseIterable,
E: CaseIterable,
F: CaseIterable,
G: CaseIterable,
H: CaseIterable,
I: CaseIterable
{
  @inlinable
  public static var allCases: some Collection<Self> {
    ChainCollection(
      A.allCases.onDemandMap(Self.init(a:)),
      B.allCases.onDemandMap(Self.init(b:)),
      C.allCases.onDemandMap(Self.init(c:)),
      D.allCases.onDemandMap(Self.init(d:)),
      E.allCases.onDemandMap(Self.init(e:)),
      F.allCases.onDemandMap(Self.init(f:)),
      G.allCases.onDemandMap(Self.init(g:)),
      H.allCases.onDemandMap(Self.init(h:)),
      I.allCases.onDemandMap(Self.init(i:))
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: - Componentwise Constructors
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex {
  
  @inlinable
  internal init(a: A) {
    self.init(position: .a(a))
  }

  @inlinable
  internal init(b: B) {
    self.init(position: .b(b))
  }

  @inlinable
  internal init(c: C) {
    self.init(position: .c(c))
  }

  @inlinable
  internal init(d: D) {
    self.init(position: .d(d))
  }

  @inlinable
  internal init(e: E) {
    self.init(position: .e(e))
  }

  @inlinable
  internal init(f: F) {
    self.init(position: .f(f))
  }

  @inlinable
  internal init(g: G) {
    self.init(position: .g(g))
  }

  @inlinable
  internal init(h: H) {
    self.init(position: .h(h))
  }

  @inlinable
  internal init(i: I) {
    self.init(position: .i(i))
  }

}

