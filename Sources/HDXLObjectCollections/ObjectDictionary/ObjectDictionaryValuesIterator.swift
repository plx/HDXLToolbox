import Foundation

// ------------------------------------------------------------------------- //
// MARK: ObjectDictionaryValuesIterator
// ------------------------------------------------------------------------- //

@frozen
public struct ObjectDictionaryValuesIterator<Key, Value>: IteratorProtocol where Key: AnyObject {
  
  public typealias Element = Value
  
  @usableFromInline
  internal typealias BaseIterator = Dictionary<ObjectWrapper<Key>, Value>.Values.Iterator
  
  @usableFromInline
  internal var iterator: BaseIterator
  
  @inlinable
  internal init(iterator: BaseIterator) {
    self.iterator = iterator
  }
  
  @inlinable
  public mutating func next() -> Element? {
    iterator.next()
  }
  
}
