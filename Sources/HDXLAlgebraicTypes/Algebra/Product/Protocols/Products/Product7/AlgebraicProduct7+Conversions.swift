import Foundation
import HDXLEssentialPrecursors

extension AlgebraicProduct7 {

  /// Shortand for "any other same-arity algebraic product of the same underlying types."
  public typealias CompatibleProduct = AlgebraicProduct7<
    A,
    B,
    C,
    D,
    E,
    F,
    G
  >
  
  /// Conversion constructor, allowing initialization from any compatible product.
  @inlinable
  public init(converting other: some CompatibleProduct) {
    self.init(tupleRepresentation: other.tupleRepresentation)
  }
  
  /// Conversion constructor, allowing initialization from any non-`nil` compatible product.
  @inlinable
  public init?(possiblyConverting possibleOther: (some CompatibleProduct)?) {
    guard let other = possibleOther else {
      return nil
    }
    self.init(converting: other)
  }

}
