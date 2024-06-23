import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct9 - Definition
// -------------------------------------------------------------------------- //

/// Protocol representing an arity-9 product type.
public protocol AlgebraicProduct9<A,B,C,D,E,F,G,H,I> : AlgebraicProduct
  where
  ArityPosition == Arity9Position 
{
  
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
  
  /// Shorthand for the corresponding, same-arity sum type.
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

}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct Defaults
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9 {
  
  @inlinable
  public static var arity: Int { 9 }
  
}

