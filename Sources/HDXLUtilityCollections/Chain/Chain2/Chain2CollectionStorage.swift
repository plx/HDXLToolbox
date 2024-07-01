import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
@AddChainCollectionStorageImplementation
@AddFixedChainCollectionStorageComponents
@AddArity2ChainCollectionStorageImplementation
internal final class Chain2CollectionStorage<A,B>
where
A:Collection,
B:Collection,
A.Element == B.Element
{ 
}

// -------------------------------------------------------------------------- //
// MARK: - Sendable
// -------------------------------------------------------------------------- //

extension Chain2CollectionStorage: @unchecked Sendable
where
A: Sendable,
B: Sendable { }

//// -------------------------------------------------------------------------- //
//// MARK: Chain2CollectionStorage - Definition
//// -------------------------------------------------------------------------- //
//
//@usableFromInline
//internal final class Chain2CollectionStorage<A,B>
//where
//A:Collection,
//B:Collection,
//A.Element == B.Element
//{
//  
//  // -------------------------------------------------------------------------- //
//  // MARK: Constituent Collections
//  // -------------------------------------------------------------------------- //
//  
//  @usableFromInline
//  @GenericCollectionStorage
//  internal var a: A {
//    didSet {
//      resetCaches()
//    }
//  }
//  
//  @usableFromInline
//  @GenericCollectionStorage
//  internal var b: B {
//    didSet {
//      resetCaches()
//    }
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Cache-Management
//  // ------------------------------------------------------------------------ //
//  
//  @inlinable
//  internal func resetCaches() {
//    self._isEmpty = nil
//    self._count = nil
//    
//    self._rangeForA = nil
//    self._rangeForB = nil
//    
//    self._firstPosition = nil
//    self._finalPosition = nil
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: isEmpty Support
//  // ------------------------------------------------------------------------ //
//  
//  @usableFromInline
//  internal var _isEmpty: Bool? = nil
//  
//  @inlinable
//  internal var isEmpty: Bool {
//    _isEmpty.obtainAssuredValue(
//      fallback: self.calculateIsEmpty()
//    )
//  }
//  
//  @inlinable
//  internal func calculateIsEmpty() -> Bool {
//    a.isEmpty
//    &&
//    b.isEmpty
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: count Support
//  // ------------------------------------------------------------------------ //
//  
//  @usableFromInline
//  internal var _count: Int? = nil
//  
//  @inlinable
//  internal var count: Int {
//    _count.obtainAssuredValue(
//      fallback: calculateCount()
//    )
//  }
//  
//  @usableFromInline
//  internal func calculateCount() -> Int {
//    switch isEmpty {
//    case true:
//      0
//    case false:
//      $a.count
//      +
//      $b.count
//    }
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Incremental Range Support - Storage
//  // ------------------------------------------------------------------------ //
//  
//  @usableFromInline
//  internal var _rangeForA: Range<Int>? = nil
//  
//  @usableFromInline
//  internal var _rangeForB: Range<Int>? = nil
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Incremental Range Support - Access
//  // ------------------------------------------------------------------------ //
//  
//  @inlinable
//  internal var rangeForA: Range<Int> {
//    _rangeForA.obtainAssuredValue(
//      fallback: calculateRangeForA()
//    )
//  }
//  
//  @inlinable
//  internal var rangeForB: Range<Int> {
//    _rangeForB.obtainAssuredValue(
//      fallback: calculateRangeForB()
//    )
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Incremental Range Support - Calculation
//  // ------------------------------------------------------------------------ //
//  
//  @usableFromInline
//  internal func calculateRangeForA() -> Range<Int> {
//    guard !isEmpty else {
//      return 0..<0
//    }
//    return 0..<$a.count
//  }
//  
//  @usableFromInline
//  internal func calculateRangeForB() -> Range<Int> {
//    guard !isEmpty else {
//      return 0..<0
//    }
//    let previousUpperBound = rangeForA.upperBound
//    let currentCount = $b.count
//    return previousUpperBound..<(previousUpperBound + currentCount)
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Index Support
//  // ------------------------------------------------------------------------ //
//  
//  @usableFromInline
//  internal typealias Index = Chain2CollectionIndex<A.Index,B.Index>
//  
//  @usableFromInline
//  internal typealias Position = Index.Position
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Extremal Position Support - Storage
//  // ------------------------------------------------------------------------ //
//  
//  @usableFromInline
//  internal var _firstPosition: Position?? = nil
//  
//  @usableFromInline
//  internal var _finalPosition: Position?? = nil
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Extremal Position Support - Access
//  // ------------------------------------------------------------------------ //
//  
//  @inlinable
//  internal var firstPosition: Position? {
//    _firstPosition.obtainAssuredValue(
//      fallback: calculateFirstPosition()
//    )
//  }
//  
//  @inlinable
//  internal var finalPosition: Position? {
//    _finalPosition.obtainAssuredValue(
//      fallback: calculateFinalPosition()
//    )
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Extremal Position Support - Calculation
//  // ------------------------------------------------------------------------ //
//  
//  @usableFromInline
//  internal func calculateFirstPosition() -> Position? {
//    // recall: lazy evaluation, first-to-last
//    Position.firstNonNil(
//      $a.firstSubscriptableIndex,
//      $b.firstSubscriptableIndex
//    )
//  }
//  
//  @usableFromInline
//  internal func calculateFinalPosition() -> Position? {
//    // recall: lazy evaluation, last-to-first
//    Position.finalNonNil(
//      $a.finalSubscriptableIndex,
//      $b.finalSubscriptableIndex
//    )
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Extremal Indices
//  // ------------------------------------------------------------------------ //
//  
//  @inlinable
//  internal var startIndex: Index {
//    guard let firstPosition = self.firstPosition else {
//      return endIndex
//    }
//    return Index(position: firstPosition)
//  }
//  
//  @inlinable
//  internal var endIndex: Index {
//    Index.endIndex
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Initialization
//  // ------------------------------------------------------------------------ //
//  
//  @inlinable
//  internal required init(
//    _ a: A,
//    _ b: B
//  ) {
//    self.a = a
//    self.b = b
//  }
//  
//  // ------------------------------------------------------------------------ //
//  // MARK: Position Support
//  // ------------------------------------------------------------------------ //
//  
//  @usableFromInline
//  internal typealias Element = A.Element
//  
//  @inlinable
//  internal subscript(position: Position) -> Element {
//    switch position {
//    case .a(let a):
//      precondition(a < self.a.endIndex)
//      return self.a[a]
//    case .b(let b):
//      precondition(b < self.b.endIndex)
//      return self.b[b]
//    }
//  }
//  
//  @usableFromInline
//  internal func position(after position: Position) -> Position? {
//    // NOTE: this blindly does all 9 advancements then figures out at the end
//    // if it "went over the edge" or not. This is more-efficient than it looks
//    // b.c the `nextSubscriptableIndex` usually just returns the supplied index,
//    // and it's *hopefully* not worth bloating this with a ton of early-exits
//    // (e.g. checking for "hold position" after each advancement and bailing).
//    guard !isEmpty else {
//      return nil
//    }
//    switch position {
//    case .a(let a):
//      guard let nextAIndex = self.$a.subscriptableIndex(after: a) else {
//        return self.firstPosition(after: .a)
//      }
//      return .a(nextAIndex)
//    case .b(let b):
//      guard let nextBIndex = self.$b.subscriptableIndex(after: b) else {
//        return self.firstPosition(after: .b)
//      }
//      return .b(nextBIndex)
//    }
//  }
//  
//  @inlinable
//  internal func position(
//    _ position: Position,
//    offsetBy distance: Int
//  ) -> Position? {
//    let linearPosition = self.linearPosition(forPosition: position)
//    let destination = linearPosition + distance
//    guard (0...self.count).contains(destination) else {
//      preconditionFailure("Invalid navigation, went from \(position) (linear: \(linearPosition)) => \(destination) (offset: \(distance)), but valid range is 0...\(count)!")
//    }
//    guard destination < self.count else {
//      return nil
//    }
//    return self.position(
//      forLinearPosition: destination
//    )
//  }
//  
//  @inlinable
//  internal func distance(
//    from start: Position,
//    to end: Position
//  ) -> Int {
//    linearPosition(forPosition: end)
//    -
//    linearPosition(forPosition: start)
//  }
//  
//}
//
//// -------------------------------------------------------------------------- //
//// MARK: - Position Advancement Support
//// -------------------------------------------------------------------------- //
//
//extension Chain2CollectionStorage {
//  
//  @usableFromInline
//  internal func firstPositionAfterA() -> Position? {
//    Position.firstNonNil(
//      nil,
//      $b.firstSubscriptableIndex
//    )
//  }
//  
//  @usableFromInline
//  internal func firstPositionAfterB() -> Position? {
//    nil
//  }
//  
//  @inlinable
//  internal func firstPosition(after position: Arity2Position) -> Position? {
//    switch position {
//    case .a:
//      firstPositionAfterA()
//    case .b:
//      firstPositionAfterB()
//    }
//  }
//  
//}
//
//// -------------------------------------------------------------------------- //
//// MARK: - Position Linearization Support
//// -------------------------------------------------------------------------- //
//
//internal extension Chain2CollectionStorage {
//  
//  @inlinable
//  func position(forLinearPosition linearPosition: Int) -> Position {
//    if self.rangeForA.contains(linearPosition) {
//      return .a(
//        self.a.index(
//          self.a.startIndex,
//          offsetBy: linearPosition - self.rangeForA.lowerBound
//        )
//      )
//    } else if self.rangeForB.contains(linearPosition) {
//      return .b(
//        self.b.index(
//          self.b.startIndex,
//          offsetBy: linearPosition - self.rangeForB.lowerBound
//        )
//      )
//    } else {
//      preconditionFailure(
//        """
//        Attempted to obtain position for out-of-bounds `linearPosition` \(linearPosition) in \(String(reflecting: self))!
//        """
//      )
//    }
//  }
//  
//  @inlinable
//  func linearPosition(forPosition position: Position) -> Int {
//    switch position {
//    case .a(let a):
//      return (
//        self.rangeForA.lowerBound
//        +
//        self.a.distance(
//          from: self.a.startIndex,
//          to: a
//        )
//      )
//    case .b(let b):
//      return (
//        self.rangeForB.lowerBound
//        +
//        self.b.distance(
//          from: self.b.startIndex,
//          to: b
//        )
//      )
//    }
//  }
//  
//}
//
//// -------------------------------------------------------------------------- //
//// MARK: - Position Retreat
//// -------------------------------------------------------------------------- //
//
//extension Chain2CollectionStorage
//where
//A:BidirectionalCollection,
//B:BidirectionalCollection
//{
//  
//  @usableFromInline
//  internal func position(before position: Position) -> Position? {
//    // NOTE: this blindly does all 9 retreats then figures out at the end
//    // if it "went over the edge" or not. This is more-efficient than it looks
//    // b.c the `previousSubscriptableIndex` usually just returns the supplied index,
//    // and it's *hopefully* not worth bloating this with a ton of early-exits
//    // (e.g. checking for "hold position" after each advancement and bailing).
//    guard !isEmpty else {
//      return nil
//    }
//    switch position {
//    case .b(let b):
//      guard let previousBIndex = $b.subscriptableIndex(before: b) else {
//        return finalPositionBeforeB()
//      }
//      return .b(previousBIndex)
//    case .a(let a):
//      guard let previousAIndex = $a.subscriptableIndex(before: a) else {
//        return finalPositionBeforeA()
//      }
//      return .a(previousAIndex)
//    }
//  }
//  
//}
//
//// -------------------------------------------------------------------------- //
//// MARK: Chain2CollectionStorage - Position Retreat Support
//// -------------------------------------------------------------------------- //
//
//extension Chain2CollectionStorage {
//  
//  @usableFromInline
//  internal func finalPositionBeforeA() -> Position? {
//    nil
//  }
//  
//  @usableFromInline
//  internal func finalPositionBeforeB() -> Position? {
//    Position.finalNonNil(
//      $a.finalSubscriptableIndex,
//      nil
//    )
//  }
//  
//  @inlinable
//  internal func finalPosition(before position: Arity2Position) -> Position? {
//    switch position {
//    case .a:
//      finalPositionBeforeA()
//    case .b:
//      finalPositionBeforeB()
//    }
//  }
//  
//}
//
//// -------------------------------------------------------------------------- //
//// MARK: Chain2CollectionStorage - With Derivation
//// -------------------------------------------------------------------------- //
//
//internal extension Chain2CollectionStorage {
//  
//  // TODO: any way to pull the cached properties over for the unchanged properties?
//  
//  @inlinable
//  func with(a: A) -> Chain2CollectionStorage<A,B> {
//    return Chain2CollectionStorage<A,B>(
//      a,
//      b
//    )
//  }
//  
//  @inlinable
//  func with(b: B) -> Chain2CollectionStorage<A,B> {
//    return Chain2CollectionStorage<A,B>(
//      a,
//      b
//    )
//  }
//  
//}
//
//// -------------------------------------------------------------------------- //
//// MARK: - Value-Exposure
//// -------------------------------------------------------------------------- //
//
//extension Chain2CollectionStorage {
//  
//  @usableFromInline
//  internal typealias AlgebraicProductRepresentation = InlineProduct2<A,B>
//  
//  @inlinable
//  internal var algebraicProductRepresentation: AlgebraicProductRepresentation {
//    AlgebraicProductRepresentation(a,b)
//  }
//  
//  @inlinable
//  internal convenience init(algebraicProductRepresentation: InlineProduct2<A, B>) {
//    self.init(
//      algebraicProductRepresentation.a,
//      algebraicProductRepresentation.b
//    )
//  }
//}
//
//// -------------------------------------------------------------------------- //
//// MARK: Chain2CollectionStorage - Sendable
//// -------------------------------------------------------------------------- //
//
//extension Chain2CollectionStorage: @unchecked Sendable
//where
//A: Sendable,
//B: Sendable { }
//
//// -------------------------------------------------------------------------- //
//// MARK: Chain2CollectionStorage - Equatable
//// -------------------------------------------------------------------------- //
//
//extension Chain2CollectionStorage : Equatable
//where
//A:Equatable,
//B:Equatable
//{
//  
//  @inlinable
//  internal static func ==(
//    lhs: Chain2CollectionStorage<A,B>,
//    rhs: Chain2CollectionStorage<A,B>
//  ) -> Bool {
//    lhs === rhs
//    ||
//    lhs.algebraicProductRepresentation == rhs.algebraicProductRepresentation
//  }
//  
//}
//
//// -------------------------------------------------------------------------- //
//// MARK: Chain2CollectionStorage - Hashable
//// -------------------------------------------------------------------------- //
//
//extension Chain2CollectionStorage : Hashable
//where
//A:Hashable,
//B:Hashable {
//  
//  @inlinable
//  internal func hash(into hasher: inout Hasher) {
//    algebraicProductRepresentation.hash(into: &hasher)
//  }
//  
//}
//
//
//// -------------------------------------------------------------------------- //
//// MARK: Chain2CollectionStorage - Codable
//// -------------------------------------------------------------------------- //
//
//extension Chain2CollectionStorage : Codable
//where
//A:Codable,
//B:Codable {
//  
//  @inlinable
//  internal func encode(to encoder: Encoder) throws {
//    var container = encoder.singleValueContainer()
//    try container.encode(algebraicProductRepresentation)
//  }
//  
//  @inlinable
//  internal convenience init(from decoder: Decoder) throws {
//    let container = try decoder.singleValueContainer()
//    self.init(
//      algebraicProductRepresentation: try container.decode(
//        AlgebraicProductRepresentation.self
//      )
//    )
//  }
//  
//}
