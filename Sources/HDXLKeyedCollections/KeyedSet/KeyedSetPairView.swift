import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

@frozen
public struct KeyedSetPairView<Key, Value> where Key: Hashable, Value: Hashable {
  
  public let keyedSet: KeyedSet<Key, Value>
  
  @inlinable
  internal init(keyedSet: KeyedSet<Key, Value>) {
    self.keyedSet = keyedSet
  }
  
}

extension KeyedSetPairView : Sendable where Key: Sendable, Value: Sendable { }
extension KeyedSetPairView : Equatable { }
extension KeyedSetPairView : Hashable { }
extension KeyedSetPairView : Codable where Key: Codable, Value: Codable { }

extension KeyedSetPairView : Collection {
  
  public typealias Element = (key: Key, value: Value)
  public typealias Index = KeyedSetPairViewIndex<Key, Value>
  
  @inlinable
  public var isEmpty: Bool {
    keyedSet.isEmpty
  }
  
  @inlinable
  public var count: Int {
    keyedSet.pairCount
  }
  
  @inlinable
  public var startIndex: Index {
    switch isEmpty {
    case true:
      endIndex
    case false:
      Index(
        outerIndex: keyedSet.storage.startIndex,
        innerIndex: keyedSet.storage.values[keyedSet.storage.startIndex].startIndex
      )
    }
  }
  
  @inlinable
  public var endIndex: Index {
    .endIndex
  }
  
  @inlinable
  public subscript(position: Index) -> Element {
    guard case .position(let position) = position.storage else {
      preconditionFailure("Tried to subscript the endIndex!")
    }
    
    return (
      key: keyedSet.storage.keys[position.outerIndex],
      value: keyedSet.storage.values[position.outerIndex][position.innerIndex]
    )
  }
  
//  @inlinable
//  public func distance(
//    from start: Index,
//    to end: Index
//  ) -> Int {
//    storage.distance(
//      from: start.index,
//      to: end.index
//    )
//  }
  
  @inlinable
  internal subscript(outerIndex outerIndex: Index.OuterIndex) -> (key: Key, value: Set<Value>) {
    keyedSet.storage[outerIndex]
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    guard case .position(let position) = i.storage else {
      preconditionFailure("Tried to advance the `endIndex` on `\(String(reflecting: self))!")
    }
    
    if let nextInnerIndex = keyedSet.storage.values[position.outerIndex].subscriptableIndex(after: position.innerIndex) {
      return Index(
        outerIndex: position.outerIndex,
        innerIndex: nextInnerIndex
      )
    } else if let nextOuterIndex = keyedSet.storage.subscriptableIndex(after: position.outerIndex) {
      return Index(
        outerIndex: nextOuterIndex,
        innerIndex: keyedSet.storage.values[nextOuterIndex].startIndex
      )
    } else {
      return endIndex
    }
  }
  
  @inlinable
  public func formIndex(after i: inout Index) {
    i = index(after: i)
  }
  
//  @inlinable
//  public func index(
//    _ i: Index,
//    offsetBy distance: Int
//  ) -> Index {
//    Index(
//      index: storage.index(
//        i.index,
//        offsetBy: distance
//      )
//    )
//  }
//  
//  @inlinable
//  public func formIndex(
//    _ i: inout Index,
//    offsetBy distance: Int
//  ) {
//    storage.formIndex(
//      &i.index,
//      offsetBy: distance
//    )
//  }
//  
//  @inlinable
//  public func index(
//    _ i: Index,
//    offsetBy distance: Int,
//    limitedBy limit: Index
//  ) -> Index? {
//    Index(
//      possibleIndex: storage.index(
//        i.index,
//        offsetBy: distance,
//        limitedBy: limit.index
//      )
//    )
//  }
//  
//  @inlinable
//  public func formIndex(
//    _ i: inout Index,
//    offsetBy distance: Int,
//    limitedBy limit: Index
//  ) -> Bool {
//    storage.formIndex(
//      &i.index,
//      offsetBy: distance,
//      limitedBy: limit.index
//    )
//  }

}

@usableFromInline
internal struct KeyedSetPairViewPosition<Key, Value> where Key: Hashable, Value: Hashable {
  @usableFromInline
  internal typealias OuterIndex = KeyedSet<Key, Value>.Storage.Index
  
  @usableFromInline
  internal typealias InnerIndex = Set<Value>.Index
  
  @usableFromInline
  internal var outerIndex: OuterIndex

  @usableFromInline
  internal var innerIndex: InnerIndex

  @inlinable
  internal init(
    outerIndex: OuterIndex,
    innerIndex: InnerIndex
  ) {
    self.outerIndex = outerIndex
    self.innerIndex = innerIndex
  }
  
}

extension KeyedSetPairViewPosition : Sendable where Key: Sendable, Value: Sendable { }
extension KeyedSetPairViewPosition : Equatable { }
extension KeyedSetPairViewPosition : Hashable { }

extension KeyedSetPairViewPosition : Comparable {
  
  @inlinable
  internal static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    ComparisonResult.coalescing(
      lhs.outerIndex <=> rhs.outerIndex,
      lhs.innerIndex <=> rhs.innerIndex
    ).impliesLessThan
  }
}

@usableFromInline
internal enum KeyedSetPairViewIndexStorage<Key, Value> where Key: Hashable, Value: Hashable {
  
  case position(KeyedSetPairViewPosition<Key, Value>)
  case endIndex
}

extension KeyedSetPairViewIndexStorage: Sendable where Key: Sendable, Value: Sendable { }
extension KeyedSetPairViewIndexStorage: Equatable { }
extension KeyedSetPairViewIndexStorage: Hashable { }

extension KeyedSetPairViewIndexStorage: Comparable {
  
  @inlinable
  internal static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    switch (lhs, rhs) {
    case (.position(let lPosition), .position(let rPosition)):
      lPosition < rPosition
    case (.position, .endIndex):
      true
    case (.endIndex, .position):
      false
    case (.endIndex, .endIndex):
      false
    }
  }
}

@frozen
public struct KeyedSetPairViewIndex<Key, Value> where Key: Hashable, Value: Hashable {

  @usableFromInline
  internal typealias Position = KeyedSetPairViewPosition<Key, Value>
  
  @usableFromInline
  internal typealias OuterIndex = Position.OuterIndex
  
  @usableFromInline
  internal typealias InnerIndex = Position.InnerIndex

  @usableFromInline
  internal typealias Storage = KeyedSetPairViewIndexStorage<Key, Value>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  internal init(
    outerIndex: OuterIndex,
    innerIndex: InnerIndex
  ) {
    self.init(
      storage: .position(
        Position(
          outerIndex: outerIndex,
          innerIndex: innerIndex
        )
      )
    )
  }
  
  @inlinable
  public static var endIndex: Self {
    Self(storage: .endIndex)
  }
}

extension KeyedSetPairViewIndex: Sendable where Key: Sendable, Value: Sendable { }
extension KeyedSetPairViewIndex: Equatable { }
extension KeyedSetPairViewIndex: Hashable { }

extension KeyedSetPairViewIndex: Comparable {
  
  @inlinable
  public static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.storage < rhs.storage
  }
}
