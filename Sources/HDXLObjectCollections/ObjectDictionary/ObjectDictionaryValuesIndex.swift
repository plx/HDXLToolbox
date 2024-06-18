import Foundation

@frozen
public struct ObjectDictionaryValuesIndex<Key, Value> where Key: AnyObject {
  
  @usableFromInline
  internal typealias Index = Dictionary<ObjectWrapper<Key>, Value>.Values.Index
  
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

extension ObjectDictionaryValuesIndex: Sendable where Key: Sendable, Value: Sendable { }
extension ObjectDictionaryValuesIndex: Equatable { }
extension ObjectDictionaryValuesIndex: Comparable {
  
  @inlinable
  public static func < (
    lhs: ObjectDictionaryValuesIndex<Key, Value>,
    rhs: ObjectDictionaryValuesIndex<Key, Value>
  ) -> Bool {
    return lhs.index < rhs.index
  }
  
}
