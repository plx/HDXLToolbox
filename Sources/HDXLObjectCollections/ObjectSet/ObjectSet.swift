import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: ObjectSet
// -------------------------------------------------------------------------- //

/// An `ObjectSet` is, literally, a "set of objects"--its elements are objects,
/// for which (a) equality (`==`) has been reduced to identity (`===`) and (b)
/// the `Hashable` value is obtained from the memory address (via `ObjectIdentifier`).
///
/// The implementation is entirely boilerplate:
///
/// 1. internally, we are a direct wrapper around a `Set<ObjectWrapper<T>>`
/// 2. externally, we suppress the use of `ObjectWrapper` and, instead, expose only `T`
///
/// ...and thus the entire codebase, here, consists of quietly wrapping-and-unwrapping
/// the underlying object values for you, call by call, method by method.
///
@frozen
public struct ObjectSet<T:AnyObject> {
  
  public typealias Element = T
  
  @usableFromInline
  internal typealias Wrapper = ObjectWrapper<T>
  
  @usableFromInline
  internal typealias Storage = Set<Wrapper>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension ObjectSet: Sendable where T: Sendable { }
extension ObjectSet: Equatable { }
extension ObjectSet: Hashable { }
extension ObjectSet : Codable where T:Codable { }

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension ObjectSet : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "object-set: \(String(describing: storage))"
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension ObjectSet : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "ObjectSet<\(String(reflecting: T.self))>(storage: \(String(reflecting: storage)))"
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomReflectable
// -------------------------------------------------------------------------- //

extension ObjectSet : CustomReflectable {
  
  @inlinable
  public var customMirror: Mirror {
    Mirror(
      self,
      unlabeledChildren: storage,
      displayStyle: .set,
      ancestorRepresentation: .suppressed
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - SingleValueCodable
// -------------------------------------------------------------------------- //

// TODO: implement this via a macro
extension ObjectSet : SingleValueCodable where T:Codable {
  public typealias SingleValueCodableRepresentation = Set<ObjectWrapper<T>>
  
  @inlinable
  public var singleValueCodableRepresentation: SingleValueCodableRepresentation {
    storage
  }
  
  @inlinable
  public init(unsafeFromSingleValueCodableRepresentation singleValueCodableRepresentation: SingleValueCodableRepresentation) throws {
    self.init(storage: singleValueCodableRepresentation)
  }

}

// -------------------------------------------------------------------------- //
// MARK: - ExpressibleByArrayLiteral
// -------------------------------------------------------------------------- //

extension ObjectSet : ExpressibleByArrayLiteral {
  
  public typealias ArrayLiteralElement = T
  
  @inlinable
  public init(arrayLiteral elements: T...) {
    self.init(
      storage: Storage(
        elements.onDemandMap {
          Wrapper(object: $0)
        }
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Sequence
// -------------------------------------------------------------------------- //

extension ObjectSet : Sequence {
  
  @inlinable
  public var underestimatedCount: Int {
    storage.underestimatedCount
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(
      iterator: storage.makeIterator()
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Collection
// -------------------------------------------------------------------------- //

extension ObjectSet : Collection {
  
  public typealias Index = ObjectSetIndex<T>
  public typealias Iterator = ObjectSetIterator<T>
  
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
    Index(
      index: storage.startIndex
    )
  }
  
  @inlinable
  public var endIndex: Index {
    Index(
      index: storage.endIndex
    )
  }
  
  @inlinable
  public subscript(index: Index) -> Element {
    storage[index.index].object
  }
  
  
  @inlinable
  public func distance(
    from start: ObjectSetIndex<T>,
    to end: ObjectSetIndex<T>
  ) -> Int {
    storage.distance(
      from: start.index,
      to: end.index
    )
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    Index(
      index: storage.index(
        after: i.index
      )
    )
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int
  ) -> Index {
    Index(
      index: storage.index(
        i.index,
        offsetBy: distance
      )
    )
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int,
    limitedBy limit: Index
  ) -> Index? {
    Index(
      possibleIndex: storage.index(
        i.index,
        offsetBy: distance,
        limitedBy: limit.index
      )
    )
  }
  
  @inlinable
  public func formIndex(after i: inout Index) {
    storage.formIndex(after: &i.index)
  }
  
  @inlinable
  public func formIndex(
    _ i: inout Index,
    offsetBy distance: Int
  ) {
    storage.formIndex(
      &i.index,
      offsetBy: distance
    )
  }
  
  @inlinable
  public func formIndex(
    _ i: inout Index,
    offsetBy distance: Int,
    limitedBy limit: Index
  ) -> Bool {
    storage.formIndex(
      &i.index,
      offsetBy: distance,
      limitedBy: limit.index
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - SetAlgebra
// -------------------------------------------------------------------------- //

extension ObjectSet : SetAlgebra {
  
  @inlinable
  public init() {
    self.init(storage: Storage())
  }
  
  @inlinable
  public func contains(_ member: Element) -> Bool {
    storage.contains(
      Wrapper(object: member)
    )
  }
  
  @inlinable
  public func union(_ other: ObjectSet<T>) -> ObjectSet<T> {
    ObjectSet<T>(
      storage: storage.union(other.storage)
    )
  }

  @inlinable
  public func intersection(_ other: ObjectSet<T>) -> ObjectSet<T> {
    ObjectSet<T>(
      storage: storage.intersection(other.storage)
    )
  }
  
  @inlinable
  public func symmetricDifference(_ other: ObjectSet<T>) -> ObjectSet<T> {
    ObjectSet<T>(
      storage: storage.symmetricDifference(other.storage)
    )
  }

  @inlinable
  public mutating func insert(
    _ newMember: Element
  ) -> (inserted: Bool, memberAfterInsert: Element) {
    let result = storage.insert(
      Wrapper(object: newMember)
    )
    return (
      inserted: result.inserted,
      memberAfterInsert: result.memberAfterInsert.object
    )
  }

  @inlinable
  mutating public func remove(_ member: Element) -> Element? {
    storage.remove(
      Wrapper(object: member)
    )?.object
  }

  @inlinable
  public mutating func update(with newMember: Element) -> Element? {
    storage.update(
      with: Wrapper(object: newMember)
    )?.object
  }
  
  @inlinable
  public mutating func formUnion(_ other: ObjectSet<Element>) {
    storage.formUnion(other.storage)
  }

  @inlinable
  public mutating func formIntersection(_ other: ObjectSet<Element>) {
    storage.formIntersection(other.storage)
  }

  @inlinable
  public mutating func formSymmetricDifference(_ other: ObjectSet<Element>) {
    storage.formSymmetricDifference(other.storage)
  }

  @inlinable
  public func subtracting(_ other: ObjectSet<Element>) -> ObjectSet<Element> {
    ObjectSet<Element>(
      storage: storage.subtracting(other.storage)
    )
  }

  @inlinable
  public func isSubset(of other: ObjectSet<Element>) -> Bool {
    return storage.isSubset(of: other.storage)
  }
  
  @inlinable
  public func isDisjoint(with other: ObjectSet<Element>) -> Bool {
    return storage.isDisjoint(with: other.storage)
  }

  @inlinable
  public func isSuperset(of other: ObjectSet<Element>) -> Bool {
    return storage.isSuperset(of: other.storage)
  }

  @inlinable
  public func isStrictSuperset(of other: ObjectSet<Element>) -> Bool {
    return storage.isStrictSuperset(of: other.storage)
  }
  
  @inlinable
  public func isStrictSubset(of other: ObjectSet<Element>) -> Bool {
    return storage.isStrictSubset(of: other.storage)
  }

  @inlinable
  public init(_ sequence: some Sequence<Element>) {
    self.init(
      storage: Storage(
        sequence.onDemandMap {
          Wrapper(object: $0)
        }
      )
    )
  }

  @inlinable
  public mutating func subtract(_ other: ObjectSet<T>) {
    storage.subtract(other.storage)
  }

}

// -------------------------------------------------------------------------- //
// MARK: - Set API Emulation
// -------------------------------------------------------------------------- //

extension ObjectSet {

  @inlinable
  init(minimumCapacity: Int) {
    self.init(
      storage: Storage(minimumCapacity: minimumCapacity)
    )
  }
  
  
  @inlinable
  public func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> ObjectSet<Element> {
    ObjectSet<Element>(
      storage: try storage.filter {
        try isIncluded($0.object)
      }
    )
  }

  @inlinable
  mutating public func popFirst() -> Element? {
    storage.popFirst()?.object
  }
  
  @inlinable
  var capacity: Int {
    storage.capacity
  }

  @inlinable
  mutating public func reserveCapacity(_ minimumCapacity: Int) {
    storage.reserveCapacity(minimumCapacity)
  }

  @inlinable
  public func map<R>(_ transform: (Element) throws -> R) rethrows -> [R] {
    try storage.map {
      try transform($0.object)
    }
  }

  
  @inlinable
  internal func promote(slice: Slice<Storage>) -> Slice<ObjectSet<Element>> {
    Slice<ObjectSet<Element>>(
      base: ObjectSet<Element>(
        storage: slice.base
      ),
      bounds:
        (
          (Index(index: slice.startIndex))
          ..<
          (Index(index: slice.endIndex))
        )
    )
  }

  @inlinable
  public func dropFirst(_ k: Int = 1) -> Slice<ObjectSet<Element>> {
    promote(
      slice: storage.dropFirst(k)
    )
  }
  
  @inlinable
  public func dropLast(_ k: Int = 1) -> Slice<ObjectSet<Element>> {
    promote(
      slice: storage.dropLast(k)
    )
  }
  
  @inlinable
  public func drop(while predicate: (Element) throws -> Bool) rethrows -> Slice<ObjectSet<Element>> {
    promote(
      slice: try storage.drop {
        try predicate($0.object)
      }
    )
  }
  
  @inlinable
  public func prefix(_ maxLength: Int) -> Slice<ObjectSet<Element>> {
    promote(
      slice: storage.prefix(maxLength)
    )
  }
  
  @inlinable
  public func prefix(while predicate: (Element) throws -> Bool) rethrows -> Slice<ObjectSet<Element>> {
    promote(
      slice: try storage.prefix {
        try predicate($0.object)
      }
    )
  }

  @inlinable
  public func suffix(_ maxLength: Int) -> Slice<ObjectSet<Element>> {
    promote(
      slice: storage.suffix(maxLength)
    )
  }
  
  @inlinable
  public func prefix(upTo end: Index) -> Slice<ObjectSet<Element>> {
    promote(
      slice: storage.prefix(
        upTo: end.index
      )
    )
  }
  
  @inlinable
  public func suffix(from start: Index) -> Slice<ObjectSet<Element>> {
    promote(
      slice: storage.suffix(
        from: start.index
      )
    )
  }
  
  @inlinable
  public func prefix(through position: Index) -> Slice<ObjectSet<Element>> {
    promote(
      slice: storage.prefix(
        through: position.index
      )
    )
  }
  
  @inlinable
  public func split(
    maxSplits: Int = Int.max,
    omittingEmptySubsequences: Bool = true,
    whereSeparator isSeparator: (Element) throws -> Bool
  ) rethrows -> [Slice<ObjectSet<Element>>] {
    let splits = try storage.split(
      maxSplits: maxSplits,
      omittingEmptySubsequences: omittingEmptySubsequences) {
      try isSeparator($0.object)
    }
    return splits.map {
      promote(slice: $0)
    }
  }
  
  @inlinable
  public func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Index? {
    guard
      let index = try storage.firstIndex(where: {
        try predicate($0.object)
      })
    else {
      return nil
    }
    return Index(index: index)
  }

  @inlinable
  public func shuffled(using generator: inout some RandomNumberGenerator) -> [Element] {
    storage.shuffled(using: &generator).map {
      $0.object
    }
  }
  
  @inlinable
  public func shuffled() -> [Element] {
    storage.shuffled().map {
      $0.object
    }
  }
  
  @inlinable
  public func forEach(_ body: (Element) throws -> Void) rethrows {
    try storage.forEach {
      try body($0.object)
    }
  }
  
  @inlinable
  public func first(where predicate: (Element) throws -> Bool) rethrows -> Element? {
    try storage.first(
      where: {
        try predicate($0.object)
      }
    )?.object
  }
  
  @inlinable
  public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {
    // DANGER ZONE LOL...but should be ok:
    try storage.withContiguousStorageIfAvailable {
      (pointerToWrappers)
      in
      // zero-width
      return try pointerToWrappers.withMemoryRebound(
        to: Element.self,
        body
      )
    }
  }
   
  @warn_unqualified_access
  @inlinable
  public func min(
    by areInIncreasingOrder: (Element, Element) throws -> Bool
  ) rethrows -> Element? {
    try storage.min {
      (lhs, rhs)
      in
      try areInIncreasingOrder(
        lhs.object,
        rhs.object
      )
    }?.object
  }
  
  @warn_unqualified_access
  @inlinable
  public func max(
    by areInIncreasingOrder: (Element, Element) throws -> Bool
  ) rethrows -> Element? {
    try storage.max {
      (lhs, rhs)
      in
      try areInIncreasingOrder(
        lhs.object,
        rhs.object
      )
    }?.object
  }
  
  @inlinable
  public func starts<V>(
    with possiblePrefix: some Sequence<V>,
    by areEquivalent: (Element, V) throws -> Bool
  ) rethrows -> Bool {
    try storage.starts(with: possiblePrefix) {
      (element, prefixElement)
      in
      try areEquivalent(element.object, prefixElement)
    }
  }
  
  @inlinable
  public func elementsEqual<V>(
    _ other: some Sequence<V>,
    by areEquivalent: (Element, V) throws -> Bool
  ) rethrows -> Bool {
    try storage.elementsEqual(other) {
      (element, otherElement)
      in
      try areEquivalent(element.object, otherElement)
    }
  }
  
  @inlinable
  public func lexicographicallyPrecedes(
    _ other: some Sequence<T>,
    by areInIncreasingOrder: (Element, Element) throws -> Bool
  ) rethrows -> Bool {
    try storage.lexicographicallyPrecedes(
      other.onDemandMap { Wrapper(object: $0) }) {
      (element, otherElement)
      in
      try areInIncreasingOrder(element.object, otherElement.object)
    }
  }

  @inlinable
  public func contains(
    where predicate: (Element) throws -> Bool
  ) rethrows -> Bool {
    try storage.contains {
      try predicate($0.object)
    }
  }
 
  @inlinable
  public func allSatisfy(
    _ predicate: (Element) throws -> Bool
  ) rethrows -> Bool {
    try storage.allSatisfy {
      try predicate($0.object)
    }
  }
  
  @inlinable
  public func reduce<Result>(
    _ initialResult: Result,
    _ nextPartialResult: (Result, Element) throws -> Result
  ) rethrows -> Result {
    try storage.reduce(initialResult) {
      try nextPartialResult($0, $1.object)
    }
  }
  
  @inlinable
  public func reduce<Result>(
    into initialResult: Result,
    _ updateAccumulatingResult: (inout Result, Element) throws -> Void
  ) rethrows -> Result {
    try storage.reduce(into: initialResult) {
      try updateAccumulatingResult(&$0, $1.object)
    }
  }
  
  @inlinable
  public func reversed() -> [Element] {
    storage.reversed().map { $0.object }
  }
  
  @inlinable
  public func compactMap<ElementOfResult>(
    _ transform: (Element) throws -> ElementOfResult?
  ) rethrows -> [ElementOfResult] {
    try storage.compactMap {
      try transform($0.object)
    }
  }
  
  @inlinable
  public func sorted(
    by areInIncreasingOrder: (Element, Element) throws -> Bool
  ) rethrows -> [Element] {
    try storage.sorted {
      try areInIncreasingOrder($0.object, $1.object)
    }.map {
      $0.object
    }
  }

  @inlinable
  public func isSubset(
    of possibleSuperset: some Sequence<T>
  ) -> Bool {
    storage.isSubset(
      of: possibleSuperset.onDemandMap { Wrapper(object: $0) }
    )
  }
  
  @inlinable
  public func isStrictSubset(
    of possibleStrictSuperset: some Sequence<T>
  ) -> Bool {
    storage.isStrictSubset(
      of: possibleStrictSuperset.onDemandMap { Wrapper(object: $0) }
    )
  }
  
  @inlinable
  public func isSuperset(
    of possibleSubset: some Sequence<T>
  ) -> Bool {
    storage.isSuperset(
      of: possibleSubset.onDemandMap { Wrapper(object: $0) }
    )
  }
  
  @inlinable
  public func isStrictSuperset(
    of possibleStrictSubset: some Sequence<T>
  ) -> Bool {
    storage.isStrictSuperset(
      of: possibleStrictSubset.onDemandMap { Wrapper(object: $0) }
    )
  }
  
  @inlinable
  public func isDisjoint(with other: some Sequence<T>) -> Bool {
    storage.isDisjoint(
      with: other.onDemandMap { Wrapper(object: $0) }
    )
  }
  
  @inlinable
  public func union(
    _ other: some Sequence<T>
  ) -> ObjectSet<Element> {
    ObjectSet<Element>(
      storage: storage.union(
        other.onDemandMap {
          Wrapper(object: $0)
        }
      )
    )
  }
  
  @inlinable
  public func subtracting(
    _ other: some Sequence<T>
  ) -> ObjectSet<Element> {
    ObjectSet<Element>(
      storage: storage.subtracting(
        other.onDemandMap {
          Wrapper(object: $0)
        }
      )
    )
  }

  @inlinable
  public func intersection(
    _ other: some Sequence<T>
  ) -> ObjectSet<Element> {
    ObjectSet<Element>(
      storage: storage.intersection(
        other.onDemandMap {
          Wrapper(object: $0)
        }
      )
    )
  }
  
  @inlinable
  public func symmetricDifference(
    _ other: some Sequence<T>
  ) -> ObjectSet<Element> {
    ObjectSet<Element>(
      storage: storage.symmetricDifference(
        other.onDemandMap {
          Wrapper(object: $0)
        }
      )
    )
  }
  
  @inlinable
  mutating public func formUnion(
    _ other: some Sequence<T>
  ) {
    storage.formUnion(
      other.onDemandMap {
        Wrapper(object: $0)
      }
    )
  }

  @inlinable
  mutating public func subtract(
    _ other: some Sequence<T>
  ) {
    storage.subtract(
      other.onDemandMap {
        Wrapper(object: $0)
      }
    )
  }
  
  @inlinable
  mutating public func formIntersection(
    _ other: some Sequence<T>
  ) {
    storage.formIntersection(
      other.onDemandMap {
        Wrapper(object: $0)
      }
    )
  }
  
  @inlinable
  mutating public func formSymmetricDifference(
    _ other: some Sequence<T>
  ) {
    storage.formSymmetricDifference(
      other.onDemandMap {
        Wrapper(object: $0)
      }
    )
  }

}

