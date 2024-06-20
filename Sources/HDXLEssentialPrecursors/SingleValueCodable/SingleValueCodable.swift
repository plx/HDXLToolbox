import Foundation

public protocol SingleValueCodable : Codable {
  
  associatedtype SingleValueCodableRepresentation: Codable
  
  var singleValueCodableRepresentation: SingleValueCodableRepresentation { get }
  
  init(unsafeFromSingleValueCodableRepresentation singleValueCodableRepresentation: SingleValueCodableRepresentation) throws
  
}

extension SingleValueCodable {
  
  @inlinable
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(singleValueCodableRepresentation)
  }
  
  @inlinable
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    try self.init(
      unsafeFromSingleValueCodableRepresentation: try container.decode(SingleValueCodableRepresentation.self)
    )
  }
  
}
