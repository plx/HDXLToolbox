//
//  AlgebraicProduct9.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct9 - Definition
// -------------------------------------------------------------------------- //

/// Protocol specifically for arity-9 products.
public protocol AlgebraicProduct9 : AlgebraicProduct
  where
  ArityPosition == Arity9Position {
  
  // ------------------------------------------------------------------------ //
  // MARK: Component Types
  // ------------------------------------------------------------------------ //
  
  /// The type of the first component.
  associatedtype A

  /// The type of the second component.
  associatedtype B
    
  /// The type of the third component.
  associatedtype C

  /// The type of the fourth component.
  associatedtype D

  /// The type of the fifth component.
  associatedtype E

  /// The type of the sixth component.
  associatedtype F

  /// The type of the seventh component.
  associatedtype G

  /// The type of the eighth component.
  associatedtype H

  /// The type of the ninth component.
  associatedtype I
  
  // ------------------------------------------------------------------------ //
  // MARK: Related Types
  // ------------------------------------------------------------------------ //
  
  /// Shorthand for the same-arity sum type.
  ///
  /// It'd be accurate to call this an "algebraic dual", but I find this name
  /// easier to follow (even if dual is arguably more-proper, here).
  typealias AssociatedSum = Sum9<A,B,C,D,E,F,G,H,I>
  
  // ------------------------------------------------------------------------ //
  // MARK: Component Properties
  // ------------------------------------------------------------------------ //

  /// The first component.
  var a: A { get set }
  
  /// The second component.
  var b: B { get set }
  
  /// The third component.
  var c: C { get set }

  /// The fourth component.
  var d: D { get set }

  /// The fifth component.
  var e: E { get set }

  /// The sixth component.
  var f: F { get set }

  /// The seventh component.
  var g: G { get set }

  /// The eighth component.
  var h: H { get set }

  /// The ninth component.
  var i: I { get set }

  // ------------------------------------------------------------------------ //
  // MARK: Initialization
  // ------------------------------------------------------------------------ //
  
  /// Componentwise initialization.
  init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I
  )
  
  // ------------------------------------------------------------------------ //
  // MARK: with-Derivation - Simple
  // ------------------------------------------------------------------------ //
  
  /// Obtain a value derived from `self`, but with `a` substituted-for `self.a`.
  func with(a: A) -> Self

  /// Obtain a value derived from `self`, but with `b` substituted-for `self.b`.
  func with(b: B) -> Self

  /// Obtain a value derived from `self`, but with `c` substituted-for `self.c`.
  func with(c: C) -> Self

  /// Obtain a value derived from `self`, but with `d` substituted-for `self.d`.
  func with(d: D) -> Self

  /// Obtain a value derived from `self`, but with `e` substituted-for `self.e`.
  func with(e: E) -> Self

  /// Obtain a value derived from `self`, but with `f` substituted-for `self.f`.
  func with(f: F) -> Self

  /// Obtain a value derived from `self`, but with `g` substituted-for `self.g`.
  func with(g: G) -> Self

  /// Obtain a value derived from `self`, but with `h` substituted-for `self.h`.
  func with(h: H) -> Self

  /// Obtain a value derived from `self`, but with `i` substituted-for `self.i`.
  func with(i: I) -> Self

  // ------------------------------------------------------------------------ //
  // MARK: with-Derivation - Preference
  // ------------------------------------------------------------------------ //
  
  /// Type-level configuration as to whether or not the `with(x:)`-style calls
  /// should use `true` or `false` when they call through to `with(x:ensureUniqueCopy:)`.
  static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { get }

  // ------------------------------------------------------------------------ //
  // MARK: with-Derivation - Complete
  // ------------------------------------------------------------------------ //
  
  /// Obtain a value derived from `self`, but with `a` substituted-for `self.a`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    a: A,
    ensureUniqueCopy: Bool) -> Self
  
  /// Obtain a value derived from `self`, but with `b` substituted-for `self.b`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    b: B,
    ensureUniqueCopy: Bool) -> Self
  
  /// Obtain a value derived from `self`, but with `c` substituted-for `self.c`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    c: C,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `d` substituted-for `self.d`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    d: D,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `e` substituted-for `self.e`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    e: E,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `f` substituted-for `self.f`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    f: F,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `g` substituted-for `self.g`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    g: G,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `h` substituted-for `self.h`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    h: H,
    ensureUniqueCopy: Bool) -> Self

  /// Obtain a value derived from `self`, but with `i` substituted-for `self.i`.
  /// When `ensureUniqueCopy` is `false` `self` *may* be returned when appropriate;
  /// when `ensureUniqueCopy` is `true` an appropriate new value will always be constructed.
  func with(
    i: I,
    ensureUniqueCopy: Bool) -> Self

}

// -------------------------------------------------------------------------- //
// MARK: - To-Tuple
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9 {

  /// Shorthand for the tuple equivalent-to `Self`.
  typealias TupleRepresentation = (A,B,C,D,E,F,G,H,I)

  /// Returns a tuple equivalent-to `self`.
  @inlinable
  public var tupleRepresentation: TupleRepresentation {
    (
      a,
      b,
      c,
      d,
      e,
      f,
      g,
      h,
      i
    )
  }
  
  @inlinable
  public init(tupleRepresentation: TupleRepresentation) {
    self.init(
      tupleRepresentation: (
        tupleRepresentation.0,
        tupleRepresentation.1,
        tupleRepresentation.2,
        tupleRepresentation.3,
        tupleRepresentation.4,
        tupleRepresentation.5,
        tupleRepresentation.6,
        tupleRepresentation.7,
        tupleRepresentation.8
      )
    )
  }

  @inlinable
  public init?(possibleTupleRepresentation: TupleRepresentation?) {
    guard let tupleRepresentation = possibleTupleRepresentation else {
      return nil
    }
    self.init(
      tupleRepresentation: tupleRepresentation
    )
  }

}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct Defaults
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9 {
  
  @inlinable
  public static var arity: Int { 9 }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Lexicographic Ordering
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9
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
      h <=> other.h,
      i <=> other.i
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: - Comparable
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9
where
Self: Comparable, 
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

extension AlgebraicProduct9 where
Self: Identifiable,
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable,
G: Identifiable,
H: Identifiable,
I: Identifiable,
ID: AlgebraicProduct9<
  A.ID,
  B.ID,
  C.ID,
  D.ID,
  E.ID,
  F.ID,
  G.ID,
  H.ID,
  I.ID
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
      h.id,
      i.id
    )
  }
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9 where Self: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describingTuple: (a, b, c, d, e, f, g, h, i))
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9 where Self: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      unlabeledArguments: (a, b, c, d, e, f, g, h, i)
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - AdditiveArithmetic
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9
where
Self: AdditiveArithmetic,
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic,
F: AdditiveArithmetic,
G: AdditiveArithmetic,
H: AdditiveArithmetic,
I: AdditiveArithmetic
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
      lhs.h + rhs.h,
      lhs.i + rhs.i
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
    lhs.i += rhs.i
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
      lhs.h - rhs.h,
      lhs.i - rhs.i
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
    lhs.i -= rhs.i
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - VectorArithmetic
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9
where
Self: VectorArithmetic,
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic,
F: VectorArithmetic,
G: VectorArithmetic,
H: VectorArithmetic,
I: VectorArithmetic
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
    i.scale(by: rhs)
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
    +
    i.magnitudeSquared
  }

}
