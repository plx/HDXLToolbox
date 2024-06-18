import Foundation

@frozen
public struct ObjectDictionaryKeysIndex<Key, Value> where Key: AnyObject {
  
  @usableFromInline
  internal typealias Index = Dictionary<ObjectWrapper<Key>, Value>.Keys.Index
  
  @usableFromInline
  internal var index: Index
  
  @inlinable
  internal init(index: Index) {
    self.index = index
  }
  
  @inlinable
  internal init?(possibleIndex: Index?) {
    guard let index = possibleIndex else {
      return nil
    }
    self.init(index: index)
  }
  
}

extension ObjectDictionaryKeysIndex: Sendable where Key: Sendable, Value: Sendable { }
extension ObjectDictionaryKeysIndex: Equatable { }
extension ObjectDictionaryKeysIndex: Comparable {
  
  @inlinable
  public static func < (
    lhs: ObjectDictionaryKeysIndex<Key, Value>,
    rhs: ObjectDictionaryKeysIndex<Key, Value>
  ) -> Bool {
    return lhs.index < rhs.index
  }
  
}
