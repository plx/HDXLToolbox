//
//  ObjectSetIndex.swift
//

import Foundation

// -------------------------------------------------------------------------- //
// MARK: ObjectSetIndex - Definition
// -------------------------------------------------------------------------- //

/// `newtype`-like wrapper for `Set.Index` values being used-by an `ObjectSet`.
@frozen
public struct ObjectSetIndex<T:AnyObject> {
  
  @usableFromInline
  internal typealias Wrapper = ObjectWrapper<T>
  
  @usableFromInline
  internal typealias Index = Set<Wrapper>.Index
  
  @usableFromInline
  internal var index: Index
  
  @inlinable
  internal init(index: Index) {
    self.index = index
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: ObjectSetIndex - Equatable
// -------------------------------------------------------------------------- //

extension ObjectSetIndex : Equatable {
  
  @inlinable
  public static func == (
    lhs: ObjectSetIndex<T>,
    rhs: ObjectSetIndex<T>
  ) -> Bool {
    return lhs.index == rhs.index
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: ObjectSetIndex - Comparable
// -------------------------------------------------------------------------- //

extension ObjectSetIndex : Comparable {
  
  @inlinable
  public static func < (
    lhs: ObjectSetIndex<T>,
    rhs: ObjectSetIndex<T>
  ) -> Bool {
    return lhs.index < rhs.index
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: ObjectSetIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension ObjectSetIndex : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "object-set-index: \(String(describing: index))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: ObjectSetIndex - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension ObjectSetIndex : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "ObjectSetIndex<\(String(reflecting: T.self))>(index: \(String(reflecting: index)))"
    }
  }
  
}
