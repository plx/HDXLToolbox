import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Chain9Collection
// -------------------------------------------------------------------------- //

/// A collection providing the contents of its constituent collections, one after the other.
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyCodable
@ConditionallyRandomAccessCollection
public struct Chain9Collection<A,B,C,D,E,F,G,H,I>
where
A: Collection,
B: Collection,
C: Collection,
D: Collection,
E: Collection,
F: Collection,
G: Collection,
H: Collection,
I: Collection,
A.Element == B.Element,
A.Element == C.Element,
A.Element == D.Element,
A.Element == E.Element,
A.Element == F.Element,
A.Element == G.Element,
A.Element == H.Element,
A.Element == I.Element
{
  
  @usableFromInline
  internal typealias Storage = Chain9CollectionStorage<A,B,C,D,E,F,G,H,I>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I
  ) {
    self.init(
      storage: Storage(
        a,
        b,
        c,
        d,
        e,
        f,
        g,
        h,
        i
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Property Exposure
// -------------------------------------------------------------------------- //

extension Chain9Collection {
  
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

  @inlinable
  public var c: C {
    get {
      storage.c
    }
    set {
      switch isKnownUniquelyReferenced(&storage) {
      case true:
        storage.c = newValue
      case false:
        storage = storage.with(
          c: newValue
        )
      }
    }
  }

  @inlinable
  public var d: D {
    get {
      storage.d
    }
    set {
      switch isKnownUniquelyReferenced(&storage) {
      case true:
        storage.d = newValue
      case false:
        storage = storage.with(
          d: newValue
        )
      }
    }
  }

  @inlinable
  public var e: E {
    get {
      storage.e
    }
    set {
      switch isKnownUniquelyReferenced(&storage) {
      case true:
        storage.e = newValue
      case false:
        storage = storage.with(
          e: newValue
        )
      }
    }
  }

  @inlinable
  public var f: F {
    get {
      storage.f
    }
    set {
      switch isKnownUniquelyReferenced(&storage) {
      case true:
        storage.f = newValue
      case false:
        storage = storage.with(
          f: newValue
        )
      }
    }
  }

  @inlinable
  public var g: G {
    get {
      storage.g
    }
    set {
      switch isKnownUniquelyReferenced(&storage) {
      case true:
        storage.g = newValue
      case false:
        storage = storage.with(
          g: newValue
        )
      }
    }
  }

  @inlinable
  public var h: H {
    get {
      storage.h
    }
    set {
      switch isKnownUniquelyReferenced(&storage) {
      case true:
        storage.h = newValue
      case false:
        storage = storage.with(
          h: newValue
        )
      }
    }
  }

  @inlinable
  public var i: I {
    get {
      storage.i
    }
    set {
      switch isKnownUniquelyReferenced(&storage) {
      case true:
        storage.i = newValue
      case false:
        storage = storage.with(
          i: newValue
        )
      }
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Chain9Collection : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(
      forCaption: "chain-of",
      describingTuple: storage.constituentTuple
    )
    
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Chain9Collection : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      unlabeledArguments: storage.constituentTuple
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Collection
// -------------------------------------------------------------------------- //

extension Chain9Collection : Collection {
  
  public typealias Element = A.Element
  public typealias Index = Chain9CollectionIndex<
    A.Index,
    B.Index,
    C.Index,
    D.Index,
    E.Index,
    F.Index,
    G.Index,
    H.Index,
    I.Index
  >
  
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

extension Chain9Collection : BidirectionalCollection
where
A: BidirectionalCollection,
B: BidirectionalCollection,
C: BidirectionalCollection,
D: BidirectionalCollection,
E: BidirectionalCollection,
F: BidirectionalCollection,
G: BidirectionalCollection,
H: BidirectionalCollection,
I: BidirectionalCollection
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
