import Foundation
import HDXLEssentialPrecursors

@frozen
public struct AdjacentPair<T> {
  public var earlierElement: T
  public var laterElement: T
  
  @inlinable
  public init(
    earlierElement: T,
    laterElement: T
  ) {
    self.earlierElement = earlierElement
    self.laterElement = laterElement
  }
  
  @inlinable
  public var tupleRepresentation: (T, T) {
    (
      earlierElement,
      laterElement
    )
  }
  
  @inlinable
  public init(tupleRepresentation: (T, T)) {
    self.init(
      earlierElement: tupleRepresentation.0,
      laterElement: tupleRepresentation.1
    )
  }
}

extension AdjacentPair: Sendable where T: Sendable { }
extension AdjacentPair: Equatable where T: Equatable { }
extension AdjacentPair: Hashable where T: Hashable { }
extension AdjacentPair: Encodable where T: Encodable { }
extension AdjacentPair: Decodable where T: Decodable { }

extension AdjacentPair: Identifiable where T: Identifiable {
  public typealias ID = AdjacentPair<T.ID>
  
  @inlinable
  public var id: ID {
    ID(
      earlierElement: earlierElement.id,
      laterElement: laterElement.id
    )
  }
}

extension AdjacentPair: CustomStringConvertible {
  @inlinable
  public var description: String {
    String(
      describingTuple: (earlierElement, laterElement)
    )
  }
}

extension AdjacentPair: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      arguments: (
        ("earlierElement", earlierElement),
        ("laterElement", laterElement)
      )
    )
  }
}
