import Foundation
import HDXLEssentialPrecursors

extension AlgebraicProduct2 {
  
  public typealias Extractor<T> = some AlgebraicProduct<(T) -> A, (T) -> B>
  public typealias WeakExtractor<T> = some AlgebraicProduct<(T) -> A?, (T) -> B?>

  /// Initializes `self` iff all arguments evaluate to non-`nil` values;
  /// early-exits and returns `nil` after encountering first `nil`.
  @inlinable
  public init?(
    possibleA a: @autoclosure () -> A?,
    possibleB b: @autoclosure () -> B?) {
    guard
      let aa = a(),
      let bb = b() 
    else {
      return nil
    }
    self.init(
      aa,
      bb
    )
  }
  
  /// Conversion constructor, allowing initialization from any compatible product.
  @inlinable
  public init(converting other: some AlgebraicProduct2<A,B>) {
    self.init(
      other.a,
      other.b
    )
  }
  
  /// Conversion constructor, allowing initialization from any non-`nil` compatible product.
  @inlinable
  public init?(possiblyConverting possibleOther: some AlgebraicProduct2<A,B>?) {
    guard let other = possibleOther else {
      return nil
    }
    self.init(converting: other)
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
  public init<T>(
    bySplaying source: T,
    using extractor: Extractor<T>
  ) {
    self.init(
      extractor.a(source),
      extractor.b(source)
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
  public init?<T>(
    byFailablySplaying source: T,
    using extractor: WeakExtractor<T>
  ) {
    guard
      let a = extractor.a(source),
      let b = extractor.b(source) 
    else {
      return nil
    }
    self.init(
      a,
      b
    )
    // ///////////////////////////////////////////////////////////////////////
    pedantic_assert(isValidOrIndifferent(self))
    // ///////////////////////////////////////////////////////////////////////
  }

}
