import Foundation
import HDXLEssentialPrecursors

extension AlgebraicProduct3 {

  /// Shortand for "any other same-arity algebraic product of the same underlying types."
  public typealias CompatibleProduct = AlgebraicProduct3<
    A,
    B,
    C
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
