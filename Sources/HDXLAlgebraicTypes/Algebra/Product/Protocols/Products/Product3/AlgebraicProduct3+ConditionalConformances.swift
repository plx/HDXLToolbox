import Foundation
import SwiftUI
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: - Lexicographic Ordering
// -------------------------------------------------------------------------- //

extension AlgebraicProduct3
where
A: Comparable,
B: Comparable,
C: Comparable
{
  
  @inlinable
  public func lexicographicOrderingRelationship(with other: Self) -> ComparisonResult {
    ComparisonResult.coalescing(
      a <=> other.a,
      b <=> other.b,
      c <=> other.c
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: - Comparable
// -------------------------------------------------------------------------- //

extension AlgebraicProduct3
where
Self: Comparable, 
A: Comparable,
B: Comparable,
C: Comparable
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

extension AlgebraicProduct3 where
Self: Identifiable,
A: Identifiable,
B: Identifiable,
C: Identifiable,
ID: AlgebraicProduct3<
  A.ID,
  B.ID,
  C.ID
> 
{
  @inlinable
  public var id: ID {
    ID(
      a.id,
      b.id,
      c.id
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension AlgebraicProduct3 where Self: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describingTuple: tupleRepresentation)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension AlgebraicProduct3 where Self: CustomDebugStringConvertible {
  
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

extension AlgebraicProduct3
where
Self: AdditiveArithmetic,
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic
{
  
  @inlinable
  public static var zero: Self {
    Self(
      .zero,
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
      lhs.b + rhs.b,
      lhs.c + rhs.c
    )
  }
  
  @inlinable
  public static func += (
    lhs: inout Self,
    rhs: Self
  ) {
    lhs.a += rhs.a
    lhs.b += rhs.b
    lhs.c += rhs.c
  }
  
  @inlinable
  public static func - (
    lhs: Self,
    rhs: Self
  ) -> Self {
    Self(
      lhs.a - rhs.a,
      lhs.b - rhs.b,
      lhs.c - rhs.c
    )
  }
  
  @inlinable
  public static func -= (
    lhs: inout Self,
    rhs: Self
  ) {
    lhs.a -= rhs.a
    lhs.b -= rhs.b
    lhs.c -= rhs.c
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - VectorArithmetic
// -------------------------------------------------------------------------- //

extension AlgebraicProduct3
where
Self: VectorArithmetic,
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic
{
  
  @inlinable
  public mutating func scale(by rhs: Double) {
    a.scale(by: rhs)
    b.scale(by: rhs)
    c.scale(by: rhs)
  }
  
  /// Returns the dot-product of this vector arithmetic instance with itself.
  @inlinable
  public var magnitudeSquared: Double {
    a.magnitudeSquared 
    +
    b.magnitudeSquared
    +
    c.magnitudeSquared
  }

}
