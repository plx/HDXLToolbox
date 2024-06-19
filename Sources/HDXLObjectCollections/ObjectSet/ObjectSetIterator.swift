//
//  ObjectSetIterator.swift
//

import Foundation

// -------------------------------------------------------------------------- //
// MARK: ObjectSetIterator - Definition
// -------------------------------------------------------------------------- //

/// `newtype`-like wrapper for `Set.Iterator` values being used-by an `ObjectSet`.
@frozen
public struct ObjectSetIterator<T:AnyObject> : IteratorProtocol {
  
  public typealias Element = T
  
  @usableFromInline
  internal typealias Wrapper = ObjectWrapper<T>
  
  @usableFromInline
  internal typealias Iterator = Set<Wrapper>.Iterator
  
  @usableFromInline
  internal var iterator: Iterator
  
  @usableFromInline
  internal init(iterator: Iterator) {
    self.iterator = iterator
  }
  
  @inlinable
  public mutating func next() -> T? {
    switch iterator.next() {
    case .some(let objectWrapper):
      objectWrapper.object
    case .none:
      nil
    }
  }
  
}
