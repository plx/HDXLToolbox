import Foundation
import SwiftUI
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: - Lexicographic Ordering
// -------------------------------------------------------------------------- //

extension AlgebraicProduct8
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable,
G: Comparable,
H: Comparable
{
  
  @inlinable
  public func lexicographicOrderingRelationship(with other: Self) -> ComparisonResult {
    ComparisonResult.coalescing(
      a <=> other.a,
      b <=> other.b,
      c <=> other.c,
      d <=> other.d,
      e <=> other.e,
      f <=> other.f,
      g <=> other.g,
      h <=> other.h
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: - Comparable
// -------------------------------------------------------------------------- //

extension AlgebraicProduct8
where
Self: Comparable, 
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable,
G: Comparable,
H: Comparable
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

extension AlgebraicProduct8 where
Self: Identifiable,
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable,
G: Identifiable,
H: Identifiable,
ID: AlgebraicProduct8<
  A.ID,
  B.ID,
  C.ID,
  D.ID,
  E.ID,
  F.ID,
  G.ID,
  H.ID
> {
  @inlinable
  public var id: ID {
    ID(
      a.id,
      b.id,
      c.id,
      d.id,
      e.id,
      f.id,
      g.id,
      h.id
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension AlgebraicProduct8 where Self: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describingTuple: (a, b, c, d, e, f, g, h))
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension AlgebraicProduct8 where Self: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      unlabeledArguments: (a, b, c, d, e, f, g, h)
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - AdditiveArithmetic
// -------------------------------------------------------------------------- //

extension AlgebraicProduct8
where
Self: AdditiveArithmetic,
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic,
F: AdditiveArithmetic,
G: AdditiveArithmetic,
H: AdditiveArithmetic
{
  
  @inlinable
  public static var zero: Self {
    Self(
      .zero,
      .zero,
      .zero,
      .zero,
      .zero,
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
      lhs.c + rhs.c,
      lhs.d + rhs.d,
      lhs.e + rhs.e,
      lhs.f + rhs.f,
      lhs.g + rhs.g,
      lhs.h + rhs.h
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
    lhs.d += rhs.d
    lhs.e += rhs.e
    lhs.f += rhs.f
    lhs.g += rhs.g
    lhs.h += rhs.h
  }
  
  @inlinable
  public static func - (
    lhs: Self,
    rhs: Self
  ) -> Self {
    Self(
      lhs.a - rhs.a,
      lhs.b - rhs.b,
      lhs.c - rhs.c,
      lhs.d - rhs.d,
      lhs.e - rhs.e,
      lhs.f - rhs.f,
      lhs.g - rhs.g,
      lhs.h - rhs.h
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
    lhs.d -= rhs.d
    lhs.e -= rhs.e
    lhs.f -= rhs.f
    lhs.g -= rhs.g
    lhs.h -= rhs.h
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - VectorArithmetic
// -------------------------------------------------------------------------- //

extension AlgebraicProduct8
where
Self: VectorArithmetic,
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic,
F: VectorArithmetic,
G: VectorArithmetic,
H: VectorArithmetic
{
  
  @inlinable
  public mutating func scale(by rhs: Double) {
    a.scale(by: rhs)
    b.scale(by: rhs)
    c.scale(by: rhs)
    d.scale(by: rhs)
    e.scale(by: rhs)
    f.scale(by: rhs)
    g.scale(by: rhs)
    h.scale(by: rhs)
  }
  
  /// Returns the dot-product of this vector arithmetic instance with itself.
  @inlinable
  public var magnitudeSquared: Double {
    a.magnitudeSquared 
    +
    b.magnitudeSquared
    +
    c.magnitudeSquared
    +
    d.magnitudeSquared
    +
    e.magnitudeSquared
    +
    f.magnitudeSquared
    +
    g.magnitudeSquared
    +
    h.magnitudeSquared
  }

}
