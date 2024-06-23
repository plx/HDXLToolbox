import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct4 - Definition
// -------------------------------------------------------------------------- //

/// Protocol representing an arity-9 product type.
public protocol AlgebraicProduct4<A,B,C,D> : AlgebraicProduct
  where
  ArityPosition == Arity4Position
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
  
  // ------------------------------------------------------------------------ //
  // MARK: Related Types
  // ------------------------------------------------------------------------ //
  
  /// Shorthand for the corresponding, same-arity sum type.
  typealias AssociatedSum = Sum4<A,B,C,D>
  
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
  
  // ------------------------------------------------------------------------ //
  // MARK: Initialization
  // ------------------------------------------------------------------------ //
  
  /// Componentwise initialization.
  init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D
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
  
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct Defaults
// -------------------------------------------------------------------------- //

extension AlgebraicProduct4 {
  
  @inlinable
  public static var arity: Int { 4 }
  
}

