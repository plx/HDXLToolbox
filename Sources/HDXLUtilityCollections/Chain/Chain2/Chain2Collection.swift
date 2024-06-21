import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - Definition
// -------------------------------------------------------------------------- //

/// A collection providing the contents of its constituent collections, one after the other.
@frozen
public struct Chain2Collection<A,B>: Collection
where
  A: Collection,
  B: Collection,
  A.Element == B.Element
{
  
  @usableFromInline
  internal typealias Storage = Chain2CollectionStorage<Element,A,B>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    // /////////////////////////////////////////////////////////////////////////
    pedanticAssert(storage.isValid)
    defer { pedanticAssert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
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
// MARK: Chain2Collection - Property Exposure
// -------------------------------------------------------------------------- //

public extension Chain2Collection {
  
  @inlinable
  var a: A {
    get {
      storage.a
    }
    set {
      // ///////////////////////////////////////////////////////////////////////
      pedanticAssert(isValid)
      defer { pedanticAssert(isValid) }
      defer { pedanticAssert(isKnownUniquelyReferenced(&storage)) }
      // ///////////////////////////////////////////////////////////////////////
      if isKnownUniquelyReferenced(&storage) {
        storage.a = newValue
      } else {
        storage = storage.with(
          a: newValue
        )
      }
    }
  }
  
  @inlinable
  var b: B {
    get {
      storage.b
    }
    set {
      // ///////////////////////////////////////////////////////////////////////
      pedanticAssert(isValid)
      defer { pedanticAssert(isValid) }
      defer { pedanticAssert(isKnownUniquelyReferenced(&storage)) }
      // ///////////////////////////////////////////////////////////////////////
      if isKnownUniquelyReferenced(&storage) {
        storage.b = newValue
      } else {
        storage = storage.with(
          b: newValue
        )
      }
    }
  }
    
}

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - Reflection Support
// -------------------------------------------------------------------------- //

internal extension Chain2Collection {
  
  @inlinable
  static var shortTypeName: String {
    "Chain2Collection"
  }
  
  @inlinable
  static var completeTypeName: String {
    String(reflecting: Self.self)
  }
    
}

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - Validatable
// -------------------------------------------------------------------------- //

extension Chain2Collection {
  
  @inlinable
  public var isValid: Bool {
    storage.isValid
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - Equatable
// -------------------------------------------------------------------------- //

extension Chain2Collection : Sendable where A: Sendable, B: Sendable { }
extension Chain2Collection : Equatable where A: Equatable, B: Equatable { }
extension Chain2Collection : Hashable where A: Hashable, B: Hashable { }

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - CustomStringConvertible
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
// MARK: Chain2Collection - CustomDebugStringConvertible
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
// MARK: Chain2Collection - Codable
// -------------------------------------------------------------------------- //

extension Chain2Collection : Encodable where A: Encoder, B: Encodable { }
extension Chain2Collection : Decodable where A: Decodable, B: Decodable { }

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - Collection
// -------------------------------------------------------------------------- //

extension Chain2Collection : Collection {
  
  public typealias Element = A.Element
  public typealias Index = Chain2CollectionIndex<A,B>
  
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
        return self.storage[position]
      case .end:
        preconditionFailure("Tried to subscript the end index on \(String(reflecting: self))!")
      }
    }
  }
  
  @inlinable
  internal func linearIndex(forIndex index: Index) -> Int {
    switch index.storage {
    case .position(let position):
      storage.linearPosition(forPosition: position)
    case .end:
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
    case .end:
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
// MARK: Chain2Collection - BidirectionalCollection
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
    case .end:
      guard let finalPosition = storage.finalPosition else {
        preconditionFailure("Tried to go back from the start index in \(String(reflecting: self))!")
      }
      return Index(position: finalPosition)
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - RandomAccessCollection
// -------------------------------------------------------------------------- //

extension Chain2Collection : RandomAccessCollection
  where
  A:RandomAccessCollection,
  B:RandomAccessCollection 
{
  
}

