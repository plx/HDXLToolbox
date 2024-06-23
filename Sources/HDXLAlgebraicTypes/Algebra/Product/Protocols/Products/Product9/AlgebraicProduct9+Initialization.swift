import Foundation
import HDXLEssentialPrecursors

extension AlgebraicProduct9 {
  
//  public typealias TupleRepresentation<T> = (
//    T.A,
//    T.B,
//    T.C,
//    T.D,
//    T.E,
//    T.F,
//    T.G,
//    T.H,
//    T.I
//  ) where T: AlgebraicProduct9
  
  public typealias CompatibleProduct<T> = some AlgebraicProduct<
    T.A,
    T.B,
    T.C,
    T.D,
    T.E,
    T.F,
    T.G,
    T.H,
    T.I
  > where T: AlgebraicProduct9
  
  public typealias Extractor<T> = some AlgebraicProduct<
    (T) -> A,
    (T) -> B,
    (T) -> C,
    (T) -> D,
    (T) -> E,
    (T) -> F,
    (T) -> G,
    (T) -> H,
    (T) -> I
  >
  
  public typealias WeakExtractor<T> = some AlgebraicProduct<
    (T) -> A?,
    (T) -> B?,
    (T) -> C?,
    (T) -> D?,
    (T) -> E?,
    (T) -> F?,
    (T) -> G?,
    (T) -> H?,
    (T) -> I?
  >

  /// Initializes `self` iff all arguments evaluate to non-`nil` values.
  @inlinable
  public init?(
    possibleA a: @autoclosure () -> A?,
    possibleB b: @autoclosure () -> B?,
    possibleC c: @autoclosure () -> C?,
    possibleD d: @autoclosure () -> D?,
    possibleE e: @autoclosure () -> E?,
    possibleF f: @autoclosure () -> F?,
    possibleG g: @autoclosure () -> G?,
    possibleH h: @autoclosure () -> H?,
    possibleI i: @autoclosure () -> I?
  ) {
    self.init(
      possibleTupleRepresentation: tupleUnwrap(
        a(),
        b(),
        c(),
        d(),
        e(),
        f(),
        g(),
        h(),
        i()
      )
    )
//    guard
//      let aa = a(),
//      let bb = b(),
//      let cc = c(),
//      let dd = d(),
//      let ee = e(),
//      let ff = f(),
//      let gg = g(),
//      let hh = h(),
//      let ii = i()
//    else {
//      return nil
//    }
//    self.init(
//      aa,
//      bb,
//      cc,
//      dd,
//      ee,
//      ff,
//      gg,
//      hh,
//      ii
//    )
  }
  
  /// Conversion constructor, allowing initialization from any compatible product.
  @inlinable
  //public init(converting other: some AlgebraicProduct9<A,B,C,D,E,F,G,H,I>) {
  public init(converting other: CompatibleProduct<Self>) {
    self.init(tupleRepresentation: other.tupleRepresentation)
//      other.a,
//      other.b,
//      other.c,
//      other.d,
//      other.e,
//      other.f,
//      other.g,
//      other.h,
//      other.i
//    )
//    self.init(
//      other.a,
//      other.b,
//      other.c,
//      other.d,
//      other.e,
//      other.f,
//      other.g,
//      other.h,
//      other.i
//    )
  }
  
  /// Conversion constructor, allowing initialization from any non-`nil` compatible product.
  @inlinable
  //  public init?(possiblyConverting possibleOther: some AlgebraicProduct9<A,B>?) {
  public init?(possiblyConverting possibleOther: some CompatibleProduct<Self>?) {
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
      tupleRepresentation: extractor.evaluate(
        on: source
      )
//      extractor.a(source),
//      extractor.b(source),
//      extractor.c(source),
//      extractor.d(source),
//      extractor.e(source),
//      extractor.f(source),
//      extractor.g(source),
//      extractor.h(source),
//      extractor.i(source)
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
    self.init(
      possibleTupleRepresentation: extractor.weaklyEvaluate(
        on: source
      )
    )
//    self.init(
//      possibleA: extractor.a(source),
//      possibleB: extractor.b(source),
//      possibleC: extractor.c(source),
//      possibleD: extractor.d(source),
//      possibleE: extractor.e(source),
//      possibleF: extractor.f(source),
//      possibleG: extractor.g(source),
//      possibleH: extractor.h(source),
//      possibleI: extractor.i(source)
//    )
  }
  

}
