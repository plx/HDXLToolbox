import Foundation
import SwiftUI
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: - Lexicographic Ordering
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2
where
A: Comparable,
B: Comparable
{
  
  @inlinable
  public func lexicographicOrderingRelationship(with other: Self) -> ComparisonResult {
    ComparisonResult.coalescing(
      lhses: tupleRepresentation,
      rhses: other.tupleRepresentation
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: - Comparable
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2
where
Self: Comparable, 
A: Comparable,
B: Comparable
{
  
  @inlinable
  public static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.lexicographicOrderingRelationship(with: rhs).impliesLessThan
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2 where
Self: Identifiable,
A: Identifiable,
B: Identifiable,
ID: AlgebraicProduct2<
  A.ID,
  B.ID
> 
{
  @inlinable
  public var id: ID {
    ID(tupleRepresentation: identifierTuple(for: tupleRepresentation))
  }
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2 where Self: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describingTuple: tupleRepresentation)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2 where Self: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      unlabeledArguments: tupleRepresentation
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - AdditiveArithmetic
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2
where
Self: AdditiveArithmetic,
A: AdditiveArithmetic,
B: AdditiveArithmetic
{
  
  @inlinable
  public static var zero: Self {
    Self(
      .zero,
      .zero
    )
  }
  
  @inlinable
  public static func + (
    lhs: Self,
    rhs: Self
  ) -> Self {
    Self(
      lhs.a + rhs.a,
      lhs.b + rhs.b
    )
  }
  
  @inlinable
  public static func += (
    lhs: inout Self,
    rhs: Self
  ) {
    lhs.a += rhs.a
    lhs.b += rhs.b
  }
  
  @inlinable
  public static func - (
    lhs: Self,
    rhs: Self
  ) -> Self {
    Self(
      lhs.a - rhs.a,
      lhs.b - rhs.b
    )
  }
  
  @inlinable
  public static func -= (
    lhs: inout Self,
    rhs: Self
  ) {
    lhs.a -= rhs.a
    lhs.b -= rhs.b
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - VectorArithmetic
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2
where
Self: VectorArithmetic,
A: VectorArithmetic,
B: VectorArithmetic
{
  
  @inlinable
  public mutating func scale(by rhs: Double) {
    a.scale(by: rhs)
    b.scale(by: rhs)
  }
  
  /// Returns the dot-product of this vector arithmetic instance with itself.
  @inlinable
  public var magnitudeSquared: Double {
    a.magnitudeSquared 
    +
    b.magnitudeSquared
  }

}
