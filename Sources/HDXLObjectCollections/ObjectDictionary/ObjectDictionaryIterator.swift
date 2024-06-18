import Foundation

@frozen
public struct ObjectDictionaryIterator<Key, Value>: IteratorProtocol where Key: AnyObject {
  
  public typealias Element = (key: Key, value: Value)
  
  @usableFromInline
  internal typealias BaseIterator = Dictionary<ObjectWrapper<Key>, Value>.Iterator
  
  @usableFromInline
  internal var iterator: BaseIterator
  
  @inlinable
  internal init(iterator: BaseIterator) {
    self.iterator = iterator
  }
  
  @inlinable
  public mutating func next() -> (key: Key, value: Value)? {
    guard let next = iterator.next() else {
      return nil
    }
    return (
      key: next.key.object,
      value: next.value
    )
  }
  
}

