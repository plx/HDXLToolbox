import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex
// -------------------------------------------------------------------------- //

@frozen
public struct Chain2CollectionIndex<A,B>
where
A:Comparable,
B:Comparable
{
  
  @usableFromInline
  internal typealias Position = Sum2<A, B>
  
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

extension Chain2CollectionIndex: Sendable where A: Sendable, B: Sendable { }
extension Chain2CollectionIndex: Equatable { }
extension Chain2CollectionIndex: Hashable where A: Hashable, B: Hashable { }
extension Chain2CollectionIndex: Identifiable, AutoIdentifiable where A: Hashable, B: Hashable { }
extension Chain2CollectionIndex: Encodable where A: Encodable, B: Encodable { }
extension Chain2CollectionIndex: Decodable where A: Decodable, B: Decodable { }

// -------------------------------------------------------------------------- //
// MARK: - Comparable
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndex: Comparable {
  
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

extension Chain2CollectionIndex: CaseIterable where A: CaseIterable, B: CaseIterable {
  @inlinable
  public static var allCases: some Collection<Self> {
    ChainCollection(
      A.allCases.onDemandMap(Self.init(a:)),
      B.allCases.onDemandMap(Self.init(b:))
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndex: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describing: storage)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndex: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(reflecting: storage)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Componentwise Constructors
// -------------------------------------------------------------------------- //

extension Chain2CollectionIndex {
  
  @inlinable
  internal init(a: A) {
    self.init(position: .a(a))
  }

  @inlinable
  internal init(b: B) {
    self.init(position: .b(b))
  }

}

