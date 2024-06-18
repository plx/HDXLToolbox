import Foundation

@frozen
public struct ObjectDictionaryIndex<Key, Value> where Key: AnyObject {
  
  @usableFromInline
  internal var index: Dictionary<ObjectWrapper<Key>, Value>.Index
  
  @inlinable
  internal init(index: Dictionary<ObjectWrapper<Key>, Value>.Index) {
    self.index = index
  }

  @inlinable
  internal init?(possibleIndex: Dictionary<ObjectWrapper<Key>, Value>.Index?) {
    guard let index = possibleIndex else {
      return nil
    }
    self.init(index: index)
  }

}

extension ObjectDictionaryIndex : Equatable { }
extension ObjectDictionaryIndex : Hashable { }
extension ObjectDictionaryIndex : Comparable {
  
  @inlinable
  public static func < (
    lhs: ObjectDictionaryIndex<Key, Value>,
    rhs: ObjectDictionaryIndex<Key, Value>
  ) -> Bool {
    return lhs.index < rhs.index
  }
  
}
