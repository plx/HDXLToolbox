import HDXLEssentialPrecursors
import HDXLCollectionSupport

public protocol KeyedCollectionProtocol<Key, Value> : Collection
where
Element == (key: Key, value: Value)
{
  associatedtype Key: Hashable
  associatedtype Value
  
  associatedtype Keys: Collection 
  where
  Keys.Element == Key
  
  associatedtype Values: MutableCollection
  where
  Values.Element == Value
  
  var keys: Keys { get }
  var values: Values { get }
  
  subscript(key: Key) -> Value? { get set }
  mutating func removeValue(forKey key: Key)
  
}
