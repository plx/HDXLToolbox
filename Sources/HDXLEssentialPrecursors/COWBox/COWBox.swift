import Foundation

@usableFromInline
package final class COWBox<Value> {
  
  @usableFromInline
  package var value: Value
  
  @inlinable
  init(value: Value) {
    self.value = value
  }
}

extension COWBox: @unchecked Sendable where Value: Sendable { }

extension COWBox: Equatable where Value: Equatable {
  @inlinable
  package static func == (
    lhs: COWBox<Value>,
    rhs: COWBox<Value>
  ) -> Bool {
    lhs.value == rhs.value
  }
}

extension COWBox: Comparable where Value: Comparable {
  @inlinable
  package static func < (
    lhs: COWBox<Value>,
    rhs: COWBox<Value>
  ) -> Bool {
    lhs.value < rhs.value
  }
}

extension COWBox: Hashable where Value: Hashable {
  @inlinable
  package func hash(into hasher: inout Hasher) {
    value.hash(into: &hasher)
  }
}

extension COWBox: Encodable where Value: Encodable {
  @inlinable
  package func encode(to encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value)
  }
}

extension COWBox: Decodable where Value: Decodable {
  @inlinable
  package convenience init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.init(
      value: try container.decode(Value.self)
    )
  }
}

extension COWBox {
  
  @inlinable
  package func obtainClone() -> COWBox<Value> {
    COWBox<Value>(value: value)
  }

  @inlinable
  package func obtainMutatedClone(
    _ mutator: (inout Value) throws -> Void
  ) rethrows -> COWBox<Value> {
    COWBox<Value>(
      value: try mutation(
        of: value,
        using: mutator
      )
    )
  }

}
