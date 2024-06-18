import Foundation

@frozen
public struct ObjectDictionaryKeysIterator<Key, Value>: IteratorProtocol where Key: AnyObject {
  
  public typealias Element = Key
  
  @usableFromInline
  internal typealias BaseIterator = Dictionary<ObjectWrapper<Key>, Value>.Keys.Iterator
  
  @usableFromInline
  internal var iterator: BaseIterator
  
  @inlinable
  internal init(iterator: BaseIterator) {
    self.iterator = iterator
  }
  
  @inlinable
  public mutating func next() -> Element? {
    guard let next = iterator.next() else {
      return nil
    }
    return next.object
  }
  
}

