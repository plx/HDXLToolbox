import HDXLEssentialPrecursors

package protocol AlgebraicProductBox<AlgebraicProductRepresentation> : AnyObject {
  associatedtype AlgebraicProductRepresentation: AlgebraicProduct
  
  var algebraicProductRepresentation: AlgebraicProductRepresentation { get set }
  
  init(unsafeFromAlgebraicProductRepresentation algebraicProductRepresentation: AlgebraicProductRepresentation) throws
  
  init(__unsafeWithValidatedAlgebraicProductRepresentation algebraicProductRepresentation: AlgebraicProductRepresentation)
}

extension AlgebraicProductBox where Self: Equatable, AlgebraicProductRepresentation: Equatable {
  @inlinable
  package static func == (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs === rhs
    ||
    lhs.algebraicProductRepresentation == rhs.algebraicProductRepresentation
  }
}

extension AlgebraicProductBox where Self: Hashable, AlgebraicProductRepresentation: Hashable {
  @inlinable
  package func hash(into hasher: inout Hasher) {
    algebraicProductRepresentation.hash(into: &hasher)
  }
}

extension AlgebraicProductBox where Self: SingleValueCodable, SingleValueCodableRepresentation == AlgebraicProductRepresentation, AlgebraicProductRepresentation: Codable {
  
  @inlinable
  package var singleValueCodableRepresentation: SingleValueCodableRepresentation {
    algebraicProductRepresentation
  }
  
  @inlinable
  package init(unsafeFromSingleValueCodableRepresentation singleValueCodableRepresentation: SingleValueCodableRepresentation) throws {
    try self.init(unsafeFromAlgebraicProductRepresentation: singleValueCodableRepresentation)
  }

}
