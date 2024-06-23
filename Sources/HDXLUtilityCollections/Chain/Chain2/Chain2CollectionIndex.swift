import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex
// -------------------------------------------------------------------------- //

@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyEncodable
@ConditionallyDecodable
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

