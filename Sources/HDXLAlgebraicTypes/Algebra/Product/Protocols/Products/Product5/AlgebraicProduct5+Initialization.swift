//
//  AlgebraicProduct5+Initialization.swift
//

import Foundation
import HDXLCommonUtilities

public extension AlgebraicProduct5 {
  
  /// Initializes `self` iff all arguments evaluate to non-`nil` values;
  /// early-exits and returns `nil` after encountering first `nil`.
  @inlinable
  init?(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?,
    _ d: @autoclosure () -> D?,
    _ e: @autoclosure () -> E?) {
    guard
      let aa = a(),
      let bb = b(),
      let cc = c(),
      let dd = d(),
      let ee = e() else {
        return nil
    }
    self.init(
      aa,
      bb,
      cc,
      dd,
      ee
    )
  }
  
  /// Conversion constructor, allowing initialization from any compatible product.
  @inlinable
  init<Other>(_ other: Other)
    where
    Other: AlgebraicProduct5,
    Other.A == Self.A,
    Other.B == Self.B,
    Other.C == Self.C,
    Other.D == Self.D,
    Other.E == Self.E {
      // ///////////////////////////////////////////////////////////////////////
      pedantic_assert(isValidOrIndifferent(other))
      // ///////////////////////////////////////////////////////////////////////
      self.init(
        other.a,
        other.b,
        other.c,
        other.d,
        other.e
      )
  }
  
  /// Conversion constructor, allowing initialization from any non-`nil` compatible product.
  @inlinable
  init?<Other>(_ other: Other?)
    where
    Other: AlgebraicProduct5,
    Other.A == Self.A,
    Other.B == Self.B,
    Other.C == Self.C,
    Other.D == Self.D,
    Other.E == Self.E {
      guard let o = other else {
        return nil
      }
      self.init(
        o.a,
        o.b,
        o.c,
        o.d,
        o.e
      )
  }

  /// "Splaying" initializer that constructs a product by applying n distinct
  /// "extractors" to the same source value. Intended for use in cases where some
  /// non-product value needs to be "projected" into a product representation.
  ///
  /// - parameter source: The common "source" value to-which all extractor values will-be applied.
  /// - parameter extractor: A product of extraction closures corresponding to the product components.
  ///
  /// - returns: A product with each component obtained by applying that component's extraction closure to `source`.
  ///
  /// - note: Alternative name suggestions would be welcomed.
  ///
  @inlinable
  init<T,Extractor>(
    bySplaying source: T,
    using extractor: Extractor)
    where
    Extractor:AlgebraicProduct5,
    Extractor.A == (T) -> A,
    Extractor.B == (T) -> B,
    Extractor.C == (T) -> C,
    Extractor.D == (T) -> D,
    Extractor.E == (T) -> E {
      // ///////////////////////////////////////////////////////////////////////
      pedantic_assert(isValidOrIndifferent(source))
      pedantic_assert(isValidOrIndifferent(extractor))
      defer { pedantic_assert(isValidOrIndifferent(self)) }
      // ///////////////////////////////////////////////////////////////////////
      self.init(
        extractor.a(source),
        extractor.b(source),
        extractor.c(source),
        extractor.d(source),
        extractor.e(source)
      )
  }

  /// Failable "Splaying" initializer that constructs a product by applying n distinct
  /// "extractors" to the same source value. Intended for use in cases where some
  /// non-product value needs to be "projected" into a product representation.
  ///
  /// Behaves like `init(bySplaying:using:)` except (a) the individual closures
  /// can return `nil` and (b) the initializer fails whenever any extractor returns `nil`.
  ///
  /// - parameter source: The common "source" value to-which all extractor values will-be applied.
  /// - parameter extractor: A product of extraction closures corresponding to the product components.
  ///
  /// - returns: A product with each component obtained by applying that component's extraction closure to `source`; `nil` if any extraction closure returns `nil`.
  ///
  /// - note: Using a distinct name to avoid confusing the type inferencer (e.g. do you want a `Product` with an `Int?` component, or a `Product?` with an `Int` component?).
  /// - note: Alternative name suggestions would be welcomed.
  ///
  @inlinable
  init?<T,Extractor>(
    byWeaklySplaying source: T,
    using extractor: Extractor)
    where
    Extractor:AlgebraicProduct5,
    Extractor.A == (T) -> A?,
    Extractor.B == (T) -> B?,
    Extractor.C == (T) -> C?,
    Extractor.D == (T) -> D?,
    Extractor.E == (T) -> E? {
      // ///////////////////////////////////////////////////////////////////////
      pedantic_assert(isValidOrIndifferent(source))
      pedantic_assert(isValidOrIndifferent(extractor))
      guard
        let a = extractor.a(source),
        let b = extractor.b(source),
        let c = extractor.c(source),
        let d = extractor.d(source),
        let e = extractor.e(source) else {
          return nil
      }
      self.init(
        a,
        b,
        c,
        d,
        e
      )
      // ///////////////////////////////////////////////////////////////////////
      pedantic_assert(isValidOrIndifferent(self))
      // ///////////////////////////////////////////////////////////////////////
  }

}
