import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct3 - Definition
// -------------------------------------------------------------------------- //

/// Protocol representing an arity-9 product type.
public protocol AlgebraicProduct3<A,B,C> : AlgebraicProduct
  where
  ArityPosition == Arity3Position
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
  
  // ------------------------------------------------------------------------ //
  // MARK: Related Types
  // ------------------------------------------------------------------------ //
  
  /// Shorthand for the corresponding, same-arity sum type.
  typealias AssociatedSum = Sum3<A,B,C>
  
  // ------------------------------------------------------------------------ //
  // MARK: Component Properties
  // ------------------------------------------------------------------------ //
  
  /// The first component.
  var a: A { get set }
  
  /// The second component.
  var b: B { get set }
  
  /// The third component.
  var c: C { get set }
  
  // ------------------------------------------------------------------------ //
  // MARK: Initialization
  // ------------------------------------------------------------------------ //
  
  /// Componentwise initialization.
  init(
    _ a: A,
    _ b: B,
    _ c: C
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
  
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct Defaults
// -------------------------------------------------------------------------- //

extension AlgebraicProduct3 {
  
  @inlinable
  public static var arity: Int { 3 }
  
}

