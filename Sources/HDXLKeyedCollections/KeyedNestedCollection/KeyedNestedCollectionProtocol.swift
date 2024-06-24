import HDXLEssentialPrecursors
import HDXLCollectionSupport

public protocol KeyedNestedCollectionProtocol<Key, Value> {
  
  associatedtype Key: Hashable
  associatedtype Value
  
  associatedtype InnerCollection: Collection
  where
  InnerCollection.Element == Value
  
  associatedtype OuterCollection: KeyedCollectionProtocol<Key, InnerCollection>
  
}

