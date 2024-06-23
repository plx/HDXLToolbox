import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct6 - Definition
// -------------------------------------------------------------------------- //

/// Protocol representing an arity-9 product type.
public protocol AlgebraicProduct6<A,B,C,D,E,F> : AlgebraicProduct
  where
  ArityPosition == Arity6Position
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
  
  // ------------------------------------------------------------------------ //
  // MARK: Related Types
  // ------------------------------------------------------------------------ //
  
  /// Shorthand for the corresponding, same-arity sum type.
  typealias AssociatedSum = Sum6<A,B,C,D,E,F>
  
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
    _ f: F
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
  
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct Defaults
// -------------------------------------------------------------------------- //

extension AlgebraicProduct6 {
  
  @inlinable
  public static var arity: Int { 6 }
  
}

