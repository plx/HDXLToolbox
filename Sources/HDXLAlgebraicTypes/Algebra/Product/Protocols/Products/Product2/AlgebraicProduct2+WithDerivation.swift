import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - `with` Derivation - Simple
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2 {
  
  @inlinable
  public func with(a: A) -> Self {
    Self(a, b)
  }

  @inlinable
  public func with(b: B) -> Self {
    Self(a, b)
  }

}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - `with` Derivation - Complete - Baseline
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct2 {
  
  @inlinable
  func with(
    a: A,
    ensureUniqueCopy: Bool) -> Self {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(isValidOrIndifferent(a))
    // /////////////////////////////////////////////////////////////////////////
    return Self(
      a,
      self.b
    )
  }

  @inlinable
  func with(
    b: B,
    ensureUniqueCopy: Bool) -> Self {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(isValidOrIndifferent(b))
    // /////////////////////////////////////////////////////////////////////////
    return Self(
      self.a,
      b
    )
  }

}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - `with` Derivation - Equatable-A
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct2 where A:Equatable {

  @inlinable
  func with(
    a: A,
    ensureUniqueCopy: Bool) -> Self {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(isValidOrIndifferent(a))
    // /////////////////////////////////////////////////////////////////////////
    guard ensureUniqueCopy || a != self.a else {
      return self
    }
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(ensureUniqueCopy || a != self.a)
    // /////////////////////////////////////////////////////////////////////////
    return Self(
      a,
      self.b
    )
  }

}

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - `with` Derivation - Equatable-B
// -------------------------------------------------------------------------- //

public extension AlgebraicProduct2 where B:Equatable {

  @inlinable
  func with(
    b: B,
    ensureUniqueCopy: Bool) -> Self {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(isValidOrIndifferent(b))
    // /////////////////////////////////////////////////////////////////////////
    guard ensureUniqueCopy || b != self.b else {
      return self
    }
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(ensureUniqueCopy || b != self.b)
    // /////////////////////////////////////////////////////////////////////////
    return Self(
      self.a,
      b
    )
  }

}
