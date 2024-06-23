import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - Definition
// -------------------------------------------------------------------------- //

/// Protocol representing an arity-9 product type.
public protocol AlgebraicProduct2<A,B> : AlgebraicProduct
  where
  ArityPosition == Arity2Position
{
  
  // ------------------------------------------------------------------------ //
  // MARK: Component Types
  // ------------------------------------------------------------------------ //
  
  /// The type of the first component.
  associatedtype A
  
  /// The type of the second component.
  associatedtype B
  
  // ------------------------------------------------------------------------ //
  // MARK: Related Types
  // ------------------------------------------------------------------------ //
  
  /// Shorthand for the corresponding, same-arity sum type.
  typealias AssociatedSum = Sum2<A,B>
  
  // ------------------------------------------------------------------------ //
  // MARK: Component Properties
  // ------------------------------------------------------------------------ //
  
  /// The first component.
  var a: A { get set }
  
  /// The second component.
  var b: B { get set }
  
  // ------------------------------------------------------------------------ //
  // MARK: Initialization
  // ------------------------------------------------------------------------ //
  
  /// Componentwise initialization.
  init(
    _ a: A,
    _ b: B
  )
  
  // ------------------------------------------------------------------------ //
  // MARK: with-Derivation - Simple
  // ------------------------------------------------------------------------ //
  
  /// Obtain a value derived from `self`, but with `a` substituted-for `self.a`.
  func with(a: A) -> Self
  
  /// Obtain a value derived from `self`, but with `b` substituted-for `self.b`.
  func with(b: B) -> Self
  
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct Defaults
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2 {
  
  @inlinable
  public static var arity: Int { 2 }
  
}

