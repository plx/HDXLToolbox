import Foundation
import HDXLEssentialPrecursors

@frozen
public struct PositionedValue<Position, Value> {
  
  public var position: Position
  public var value: Value
  
  @inlinable
  public init(position: Position, value: Value) {
    self.position = position
    self.value = value
  }
}

extension PositionedValue: Sendable where Position: Sendable, Value: Sendable { }
extension PositionedValue: Equatable where Position: Equatable, Value: Equatable { }
extension PositionedValue: Hashable where Position: Hashable, Value: Hashable { }
extension PositionedValue: Encodable where Position: Encodable, Value: Encodable { }
extension PositionedValue: Decodable where Position: Decodable, Value: Decodable { }

extension PositionedValue: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(
      describingTuple: (position, value)
    )
  }
  
}

extension PositionedValue: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: self,
      arguments: (
        ("position", position),
        ("value", value)
      )
    )
  }
}
