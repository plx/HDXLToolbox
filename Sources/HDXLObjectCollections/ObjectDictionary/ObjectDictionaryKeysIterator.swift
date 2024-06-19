import Foundation

// ------------------------------------------------------------------------- //
// MARK: ObjectDictionaryKeysIterator
// ------------------------------------------------------------------------- //

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
    switch iterator.next() {
    case .some(let objectWrapper):
      objectWrapper.object
    case .none:
      nil
    }
  }
  
}

