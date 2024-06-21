import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

@frozen
public struct KeyedSetElement<Key, Value> where Key: Hashable, Value: Hashable {
  
  public var key: Key
  public var values: Set<Value>
  
  @inlinable
  internal init(
    key: Key,
    values: Set<Value>
  ) {
    pedanticAssert(!values.isEmpty)
    self.key = key
    self.values = values
  }

  @inlinable
  internal init?(
    key: Key,
    possibleValues: Set<Value>?
  ) {
    guard 
      let values = possibleValues,
      !values.isEmpty
    else {
      return nil
    }
    self.init(
      key: key,
      values: values
    )
  }

  @inlinable
  internal init(
    element: [Key: Set<Value>].Element
  ) {
    self.init(
      key: element.key,
      values: element.value
    )
  }
}

extension KeyedSetElement: Sendable where Key: Sendable, Value: Sendable { }
extension KeyedSetElement: Equatable { }
extension KeyedSetElement: Hashable { }
extension KeyedSetElement: Encodable where Key: Encodable, Value: Encodable { }
extension KeyedSetElement: Decodable where Key: Decodable, Value: Decodable { }

extension KeyedSetElement: Identifiable where Key: Identifiable, Value: Identifiable {
  public typealias ID = KeyedSetElement<Key.ID, Value.ID>
  
  @inlinable
  public var id: ID {
    ID(
      key: key.id,
      values: values.setMap(transformation: \.id)
    )
  }
  
}

extension KeyedSetElement: CustomStringConvertible {
  
  public var description: String {
    "\(key) => \(values.stringLiteralRepresentation)"
  }
  
}

extension KeyedSetElement: CustomDebugStringConvertible {
  
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      arguments: (
        ("key", key),
        ("values", values)
      )
    )
  }
  
}
