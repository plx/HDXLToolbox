import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - Definition
// -------------------------------------------------------------------------- //

/// A collection providing the contents of its constituent collections, one after the other.
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyRandomAccessCollection
public struct Chain2Collection<A,B>
where
  A: Collection,
  B: Collection,
  A.Element == B.Element
{
  
  @usableFromInline
  internal typealias Storage = Chain2CollectionStorage<A,B>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  public init(
    _ a: A,
    _ b: B
  ) {
    self.init(
      storage: Storage(
        a,
        b
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension Chain2Collection {
  
  @inlinable
  public var a: A {
    get {
      storage.a
    }
    set {
      switch isKnownUniquelyReferenced(&storage) {
      case true:
        storage.a = newValue
      case false:
        storage = storage.with(
          a: newValue
        )
      }
    }
  }
  
  @inlinable
  public var b: B {
    get {
      storage.b
    }
    set {
      switch isKnownUniquelyReferenced(&storage) {
      case true:
        storage.b = newValue
      case false:
        storage = storage.with(
          b: newValue
        )
      }
    }
  }
    
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain2Collection : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(
      forCaption: "chain-of",
      describingTuple: (a, b)
    )
    
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Chain2Collection : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      unlabeledArguments: (a, b)
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Collection
// -------------------------------------------------------------------------- //

extension Chain2Collection : Collection {
  
  public typealias Element = A.Element
  public typealias Index = Chain2CollectionIndex<A.Index, B.Index>
  
  @inlinable
  public var isEmpty: Bool {
    storage.isEmpty
  }
  
  @inlinable
  public var count: Int {
    storage.count
  }
  
  @inlinable
  public var startIndex: Index {
    storage.startIndex
  }
  
  @inlinable
  public var endIndex: Index {
    storage.endIndex
  }
  
  @inlinable
  public subscript(index: Index) -> Element {
    get {
      switch index.storage {
      case .position(let position):
        return storage[position]
      case .endIndex:
        preconditionFailure("Tried to subscript the end index on \(String(reflecting: self))!")
      }
    }
  }
  
  @inlinable
  internal func linearIndex(forIndex index: Index) -> Int {
    switch index.storage {
    case .position(let position):
      storage.linearPosition(forPosition: position)
    case .endIndex:
      count
    }
  }
  
  @inlinable
  internal func index(forLinearIndex linearIndex: Int) -> Index {
    guard (0...count).contains(linearIndex) else {
      preconditionFailure("Attempted to convert invalid linearIndex \(linearIndex) to index in \(String(reflecting: self))!")
    }
    guard linearIndex < count else {
      return endIndex
    }
    return Index(
      position: storage.position(
        forLinearPosition: linearIndex
      )
    )
  }
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index
  ) -> Int {
    return (
      linearIndex(forIndex: end)
      -
      linearIndex(forIndex: start)
    )
  }
  
  @inlinable
  public func index(after index: Index) -> Index {
    switch index.storage {
    case .position(let position):
      guard let nextPosition = storage.position(after: position) else {
        return endIndex
      }
      return Index(position: nextPosition)
    case .endIndex:
      preconditionFailure("Tried to advance the end index on \(String(reflecting: self))!")
    }
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int
  ) -> Index {
    guard distance != 0 else {
      return i
    }
    return index(
      forLinearIndex: (
        linearIndex(forIndex: i)
        +
        distance
      )
    )
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int,
    limitedBy limit: Index
  ) -> Index? {
    let destination = linearIndex(forIndex: i) + distance
    let boundary = linearIndex(forIndex: limit)
    if distance < 0 {
      guard boundary <= destination else {
        return nil
      }
      return index(forLinearIndex: destination)
    } else if distance > 0 {
      guard destination <= boundary else {
        return nil
      }
      return index(forLinearIndex: destination)
    } else {
      return i
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - BidirectionalCollection
// -------------------------------------------------------------------------- //

extension Chain2Collection : BidirectionalCollection
  where
  A:BidirectionalCollection,
  B:BidirectionalCollection 
{
  
  @inlinable
  public func index(before index: Index) -> Index {
    precondition(index > startIndex)
    switch index.storage {
    case .position(let position):
      guard let previousPosition = storage.position(before: position) else {
        preconditionFailure("Tried to go back from the start index in \(String(reflecting: self))!")
      }
      return Index(position: previousPosition)
    case .endIndex:
      guard let finalPosition = storage.finalPosition else {
        preconditionFailure("Tried to go back from the start index in \(String(reflecting: self))!")
      }
      return Index(position: finalPosition)
    }
  }
  
}
