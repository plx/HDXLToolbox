import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionIndex
// -------------------------------------------------------------------------- //

@frozen
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
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex: Sendable
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

extension Chain9CollectionIndex: Equatable
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

extension Chain9CollectionIndex: Hashable 
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

extension Chain9CollectionIndex: Identifiable, AutoIdentifiable 
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

extension Chain9CollectionIndex: Encodable 
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

extension Chain9CollectionIndex: Decodable
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

// -------------------------------------------------------------------------- //
// MARK: - Comparable
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex: Comparable {
  
  @inlinable
  public static func <(
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.storage < rhs.storage
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
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describing: storage)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Chain9CollectionIndex: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(reflecting: storage)
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

