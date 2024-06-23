import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes

// -------------------------------------------------------------------------- //
// MARK: Chain8CollectionStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
internal final class Chain8CollectionStorage<A,B,C,D,E,F,G,H>
where
A: Collection,
B: Collection,
C: Collection,
D: Collection,
E: Collection,
F: Collection,
G: Collection,
H: Collection,
A.Element == B.Element,
A.Element == C.Element,
A.Element == D.Element,
A.Element == E.Element,
A.Element == F.Element,
A.Element == G.Element,
A.Element == H.Element
{
  
  // -------------------------------------------------------------------------- //
  // MARK: Constituent Collections
  // -------------------------------------------------------------------------- //
  
  @usableFromInline
  @GenericCollectionStorage
  internal var a: A {
    didSet {
      resetCaches()
    }
  }
  
  @usableFromInline
  @GenericCollectionStorage
  internal var b: B {
    didSet {
      resetCaches()
    }
  }

  @usableFromInline
  @GenericCollectionStorage
  internal var c: C {
    didSet {
      resetCaches()
    }
  }

  @usableFromInline
  @GenericCollectionStorage
  internal var d: D {
    didSet {
      resetCaches()
    }
  }

  @usableFromInline
  @GenericCollectionStorage
  internal var e: E {
    didSet {
      resetCaches()
    }
  }

  @usableFromInline
  @GenericCollectionStorage
  internal var f: F {
    didSet {
      resetCaches()
    }
  }

  @usableFromInline
  @GenericCollectionStorage
  internal var g: G {
    didSet {
      resetCaches()
    }
  }

  @usableFromInline
  @GenericCollectionStorage
  internal var h: H {
    didSet {
      resetCaches()
    }
  }
  
  // ----------------------------------------------------------------------- //
  // MARK: Constituent Tuple
  // ----------------------------------------------------------------------- //
  
  @usableFromInline
  internal typealias ConstituentTuple = (A,B,C,D,E,F,G,H)
  
  @inlinable
  internal var constituentTuple: ConstituentTuple {
    (a,b,c,d,e,f,g,h)
  }
  
  @inlinable
  internal convenience init(constituentTuple: ConstituentTuple) {
    self.init(
      constituentTuple.0,
      constituentTuple.1,
      constituentTuple.2,
      constituentTuple.3,
      constituentTuple.4,
      constituentTuple.5,
      constituentTuple.6,
      constituentTuple.7
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: Cache-Management
  // ------------------------------------------------------------------------ //
  
  @inlinable
  internal func resetCaches() {
    self._isEmpty = nil
    self._count = nil
    
    self._rangeForA = nil
    self._rangeForB = nil
    self._rangeForC = nil
    self._rangeForD = nil
    self._rangeForE = nil
    self._rangeForF = nil
    self._rangeForG = nil
    self._rangeForH = nil
    
    self._firstPosition = nil
    self._finalPosition = nil
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: isEmpty Support
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal var _isEmpty: Bool? = nil
  
  @inlinable
  internal var isEmpty: Bool {
    _isEmpty.obtainAssuredValue(
      fallback: self.calculateIsEmpty()
    )
  }
  
  @inlinable
  internal func calculateIsEmpty() -> Bool {
    allAreEmpty(in: constituentTuple)
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: count Support
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal var _count: Int? = nil
  
  @inlinable
  internal var count: Int {
    _count.obtainAssuredValue(
      fallback: calculateCount()
    )
  }
  
  @usableFromInline
  internal func calculateCount() -> Int {
    switch isEmpty {
    case true:
      0
    case false:
      totalCount(in: constituentTuple)
    }
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Incremental Range Support - Storage
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal var _rangeForA: Range<Int>? = nil
  
  @usableFromInline
  internal var _rangeForB: Range<Int>? = nil

  @usableFromInline
  internal var _rangeForC: Range<Int>? = nil

  @usableFromInline
  internal var _rangeForD: Range<Int>? = nil

  @usableFromInline
  internal var _rangeForE: Range<Int>? = nil

  @usableFromInline
  internal var _rangeForF: Range<Int>? = nil

  @usableFromInline
  internal var _rangeForG: Range<Int>? = nil

  @usableFromInline
  internal var _rangeForH: Range<Int>? = nil

  // ------------------------------------------------------------------------ //
  // MARK: Incremental Range Support - Access
  // ------------------------------------------------------------------------ //
  
  @inlinable
  internal var rangeForA: Range<Int> {
    _rangeForA.obtainAssuredValue(
      fallback: calculateRangeForA()
    )
  }
  
  @inlinable
  internal var rangeForB: Range<Int> {
    _rangeForB.obtainAssuredValue(
      fallback: calculateRangeForB()
    )
  }

  @inlinable
  internal var rangeForC: Range<Int> {
    _rangeForC.obtainAssuredValue(
      fallback: calculateRangeForC()
    )
  }

  @inlinable
  internal var rangeForD: Range<Int> {
    _rangeForD.obtainAssuredValue(
      fallback: calculateRangeForD()
    )
  }

  @inlinable
  internal var rangeForE: Range<Int> {
    _rangeForE.obtainAssuredValue(
      fallback: calculateRangeForE()
    )
  }

  @inlinable
  internal var rangeForF: Range<Int> {
    _rangeForF.obtainAssuredValue(
      fallback: calculateRangeForF()
    )
  }

  @inlinable
  internal var rangeForG: Range<Int> {
    _rangeForG.obtainAssuredValue(
      fallback: calculateRangeForG()
    )
  }

  @inlinable
  internal var rangeForH: Range<Int> {
    _rangeForH.obtainAssuredValue(
      fallback: calculateRangeForH()
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: Incremental Range Support - Calculation
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal func calculateRangeForA() -> Range<Int> {
    guard !isEmpty else {
      return 0..<0
    }
    return 0..<$a.count
  }
  
  @usableFromInline
  internal func calculateRangeForB() -> Range<Int> {
    guard !isEmpty else {
      return 0..<0
    }
    let previousUpperBound = rangeForA.upperBound
    let currentCount = $b.count
    return previousUpperBound..<(previousUpperBound + currentCount)
  }

  @usableFromInline
  internal func calculateRangeForC() -> Range<Int> {
    guard !isEmpty else {
      return 0..<0
    }
    let previousUpperBound = rangeForB.upperBound
    let currentCount = $c.count
    return previousUpperBound..<(previousUpperBound + currentCount)
  }

  @usableFromInline
  internal func calculateRangeForD() -> Range<Int> {
    guard !isEmpty else {
      return 0..<0
    }
    let previousUpperBound = rangeForC.upperBound
    let currentCount = $d.count
    return previousUpperBound..<(previousUpperBound + currentCount)
  }

  @usableFromInline
  internal func calculateRangeForE() -> Range<Int> {
    guard !isEmpty else {
      return 0..<0
    }
    let previousUpperBound = rangeForD.upperBound
    let currentCount = $e.count
    return previousUpperBound..<(previousUpperBound + currentCount)
  }

  @usableFromInline
  internal func calculateRangeForF() -> Range<Int> {
    guard !isEmpty else {
      return 0..<0
    }
    let previousUpperBound = rangeForE.upperBound
    let currentCount = $f.count
    return previousUpperBound..<(previousUpperBound + currentCount)
  }

  @usableFromInline
  internal func calculateRangeForG() -> Range<Int> {
    guard !isEmpty else {
      return 0..<0
    }
    let previousUpperBound = rangeForF.upperBound
    let currentCount = $g.count
    return previousUpperBound..<(previousUpperBound + currentCount)
  }

  @usableFromInline
  internal func calculateRangeForH() -> Range<Int> {
    guard !isEmpty else {
      return 0..<0
    }
    let previousUpperBound = rangeForG.upperBound
    let currentCount = $h.count
    return previousUpperBound..<(previousUpperBound + currentCount)
  }

  // ------------------------------------------------------------------------ //
  // MARK: Index Support
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal typealias Index = Chain8CollectionIndex<
    A.Index,
    B.Index,
    C.Index,
    D.Index,
    E.Index,
    F.Index,
    G.Index,
    H.Index
  >
  
  @usableFromInline
  internal typealias Position = Index.Position
  
  // ------------------------------------------------------------------------ //
  // MARK: Extremal Position Support - Storage
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal var _firstPosition: Position?? = nil
  
  @usableFromInline
  internal var _finalPosition: Position?? = nil
  
  // ------------------------------------------------------------------------ //
  // MARK: Extremal Position Support - Access
  // ------------------------------------------------------------------------ //
  
  @inlinable
  internal var firstPosition: Position? {
    _firstPosition.obtainAssuredValue(
      fallback: calculateFirstPosition()
    )
  }
  
  @inlinable
  internal var finalPosition: Position? {
    _finalPosition.obtainAssuredValue(
      fallback: calculateFinalPosition()
    )
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Extremal Position Support - Calculation
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal func calculateFirstPosition() -> Position? {
    // recall: lazy evaluation, first-to-last
    Position.firstNonNil(
      $a.firstSubscriptableIndex,
      $b.firstSubscriptableIndex,
      $c.firstSubscriptableIndex,
      $d.firstSubscriptableIndex,
      $e.firstSubscriptableIndex,
      $f.firstSubscriptableIndex,
      $g.firstSubscriptableIndex,
      $h.firstSubscriptableIndex
    )
  }
  
  @usableFromInline
  internal func calculateFinalPosition() -> Position? {
    // recall: lazy evaluation, last-to-first
    Position.finalNonNil(
      $a.finalSubscriptableIndex,
      $b.finalSubscriptableIndex,
      $c.finalSubscriptableIndex,
      $d.finalSubscriptableIndex,
      $e.finalSubscriptableIndex,
      $f.finalSubscriptableIndex,
      $g.finalSubscriptableIndex,
      $h.finalSubscriptableIndex
    )
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Extremal Indices
  // ------------------------------------------------------------------------ //
  
  @inlinable
  internal var startIndex: Index {
    guard let firstPosition = firstPosition else {
      return endIndex
    }
    return Index(position: firstPosition)
  }
  
  @inlinable
  internal var endIndex: Index {
    Index.endIndex
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Initialization
  // ------------------------------------------------------------------------ //
  
  @inlinable
  internal required init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H
  ) {
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    self.e = e
    self.f = f
    self.g = g
    self.h = h
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Position Support
  // ------------------------------------------------------------------------ //
  
  @usableFromInline
  internal typealias Element = A.Element
  
  @inlinable
  internal subscript(position: Position) -> Element {
    switch position {
    case .a(let a):
      precondition(a < self.a.endIndex)
      return self.a[a]
    case .b(let b):
      precondition(b < self.b.endIndex)
      return self.b[b]
    case .c(let c):
      precondition(c < self.c.endIndex)
      return self.c[c]
    case .d(let d):
      precondition(d < self.d.endIndex)
      return self.d[d]
    case .e(let e):
      precondition(e < self.e.endIndex)
      return self.e[e]
    case .f(let f):
      precondition(f < self.f.endIndex)
      return self.f[f]
    case .g(let g):
      precondition(g < self.g.endIndex)
      return self.g[g]
    case .h(let h):
      precondition(h < self.h.endIndex)
      return self.h[h]
    }
  }
  
  @usableFromInline
  internal func position(after position: Position) -> Position? {
    // NOTE: this blindly does all 9 advancements then figures out at the end
    // if it "went over the edge" or not. This is more-efficient than it looks
    // b.c the `nextSubscriptableIndex` usually just returns the supplied index,
    // and it's *hopefully* not worth bloating this with a ton of early-exits
    // (e.g. checking for "hold position" after each advancement and bailing).
    guard !isEmpty else {
      return nil
    }
    switch position {
    case .a(let a):
      guard let nextAIndex = $a.subscriptableIndex(after: a) else {
        return firstPosition(after: .a)
      }
      return .a(nextAIndex)
    case .b(let b):
      guard let nextBIndex = $b.subscriptableIndex(after: b) else {
        return firstPosition(after: .b)
      }
      return .b(nextBIndex)
    case .c(let c):
      guard let nextCIndex = $c.subscriptableIndex(after: c) else {
        return firstPosition(after: .c)
      }
      return .c(nextCIndex)
    case .d(let d):
      guard let nextDIndex = $d.subscriptableIndex(after: d) else {
        return firstPosition(after: .d)
      }
      return .d(nextDIndex)
    case .e(let e):
      guard let nextEIndex = $e.subscriptableIndex(after: e) else {
        return firstPosition(after: .e)
      }
      return .e(nextEIndex)
    case .f(let f):
      guard let nextFIndex = $f.subscriptableIndex(after: f) else {
        return firstPosition(after: .f)
      }
      return .f(nextFIndex)
    case .g(let g):
      guard let nextGIndex = $g.subscriptableIndex(after: g) else {
        return firstPosition(after: .g)
      }
      return .g(nextGIndex)
    case .h(let h):
      guard let nextHIndex = self.$h.subscriptableIndex(after: h) else {
        return firstPosition(after: .h)
      }
      return .h(nextHIndex)
    }
  }
  
  @inlinable
  internal func position(
    _ position: Position,
    offsetBy distance: Int
  ) -> Position? {
    let linearPosition = self.linearPosition(forPosition: position)
    let destination = linearPosition + distance
    guard (0...self.count).contains(destination) else {
      preconditionFailure("Invalid navigation, went from \(position) (linear: \(linearPosition)) => \(destination) (offset: \(distance)), but valid range is 0...\(count)!")
    }
    guard destination < self.count else {
      return nil
    }
    return self.position(
      forLinearPosition: destination
    )
  }
  
  @inlinable
  internal func distance(
    from start: Position,
    to end: Position
  ) -> Int {
    linearPosition(forPosition: end)
    -
    linearPosition(forPosition: start)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Position Advancement Support
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage {
  
  @usableFromInline
  internal func firstPositionAfterA() -> Position? {
    Position.firstNonNil(
      nil,
      $b.firstSubscriptableIndex,
      $c.firstSubscriptableIndex,
      $d.firstSubscriptableIndex,
      $e.firstSubscriptableIndex,
      $f.firstSubscriptableIndex,
      $g.firstSubscriptableIndex,
      $h.firstSubscriptableIndex
    )
  }
  
  @usableFromInline
  internal func firstPositionAfterB() -> Position? {
    Position.firstNonNil(
      nil,
      nil,
      $c.firstSubscriptableIndex,
      $d.firstSubscriptableIndex,
      $e.firstSubscriptableIndex,
      $f.firstSubscriptableIndex,
      $g.firstSubscriptableIndex,
      $h.firstSubscriptableIndex
    )
  }

  @usableFromInline
  internal func firstPositionAfterC() -> Position? {
    Position.firstNonNil(
      nil,
      nil,
      nil,
      $d.firstSubscriptableIndex,
      $e.firstSubscriptableIndex,
      $f.firstSubscriptableIndex,
      $g.firstSubscriptableIndex,
      $h.firstSubscriptableIndex
    )
  }

  @usableFromInline
  internal func firstPositionAfterD() -> Position? {
    Position.firstNonNil(
      nil,
      nil,
      nil,
      nil,
      $e.firstSubscriptableIndex,
      $f.firstSubscriptableIndex,
      $g.firstSubscriptableIndex,
      $h.firstSubscriptableIndex
    )
  }

  @usableFromInline
  internal func firstPositionAfterE() -> Position? {
    Position.firstNonNil(
      nil,
      nil,
      nil,
      nil,
      nil,
      $f.firstSubscriptableIndex,
      $g.firstSubscriptableIndex,
      $h.firstSubscriptableIndex
    )
  }

  @usableFromInline
  internal func firstPositionAfterF() -> Position? {
    Position.firstNonNil(
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      $g.firstSubscriptableIndex,
      $h.firstSubscriptableIndex
    )
  }

  @usableFromInline
  internal func firstPositionAfterG() -> Position? {
    Position.firstNonNil(
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      $h.firstSubscriptableIndex
    )
  }

  @usableFromInline
  internal func firstPositionAfterH() -> Position? {
    Position.firstNonNil(
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil
    )
  }

  @usableFromInline
  internal func firstPositionAfterI() -> Position? {
    nil
  }

  @inlinable
  internal func firstPosition(after position: Arity8Position) -> Position? {
    switch position {
    case .a:
      firstPositionAfterA()
    case .b:
      firstPositionAfterB()
    case .c:
      firstPositionAfterC()
    case .d:
      firstPositionAfterD()
    case .e:
      firstPositionAfterE()
    case .f:
      firstPositionAfterF()
    case .g:
      firstPositionAfterG()
    case .h:
      firstPositionAfterH()
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Position Linearization Support
// -------------------------------------------------------------------------- //

internal extension Chain8CollectionStorage {
  
  @inlinable
  func position(forLinearPosition linearPosition: Int) -> Position {
    if self.rangeForA.contains(linearPosition) {
      return .a(
        self.a.index(
          self.a.startIndex,
          offsetBy: linearPosition - self.rangeForA.lowerBound
        )
      )
    } else if self.rangeForB.contains(linearPosition) {
      return .b(
        self.b.index(
          self.b.startIndex,
          offsetBy: linearPosition - self.rangeForB.lowerBound
        )
      )
    } else {
      preconditionFailure(
        """
        Attempted to obtain position for out-of-bounds `linearPosition` \(linearPosition) in \(String(reflecting: self))!
        """
      )
    }
  }
  
  @inlinable
  func linearPosition(forPosition position: Position) -> Int {
    switch position {
    case .a(let aIndex):
      rangeForA.lowerBound
      +
      a.distance(
        from: a.startIndex,
        to: aIndex
      )
    case .b(let bIndex):
      rangeForB.lowerBound
      +
      b.distance(
        from: b.startIndex,
        to: bIndex
      )
    case .c(let cIndex):
      rangeForC.lowerBound
      +
      c.distance(
        from: c.startIndex,
        to: cIndex
      )
    case .d(let dIndex):
      rangeForD.lowerBound
      +
      d.distance(
        from: d.startIndex,
        to: dIndex
      )
    case .e(let eIndex):
      rangeForE.lowerBound
      +
      e.distance(
        from: e.startIndex,
        to: eIndex
      )
    case .f(let fIndex):
      rangeForF.lowerBound
      +
      f.distance(
        from: f.startIndex,
        to: fIndex
      )
    case .g(let gIndex):
      rangeForG.lowerBound
      +
      g.distance(
        from: g.startIndex,
        to: gIndex
      )
    case .h(let hIndex):
      rangeForH.lowerBound
      +
      h.distance(
        from: h.startIndex,
        to: hIndex
      )
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Position Retreat
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage
where
A: BidirectionalCollection,
B: BidirectionalCollection,
C: BidirectionalCollection,
D: BidirectionalCollection,
E: BidirectionalCollection,
F: BidirectionalCollection,
G: BidirectionalCollection,
H: BidirectionalCollection
{
  
  @usableFromInline
  internal func position(before position: Position) -> Position? {
    // NOTE: this blindly does all 9 retreats then figures out at the end
    // if it "went over the edge" or not. This is more-efficient than it looks
    // b.c the `previousSubscriptableIndex` usually just returns the supplied index,
    // and it's *hopefully* not worth bloating this with a ton of early-exits
    // (e.g. checking for "hold position" after each advancement and bailing).
    guard !isEmpty else {
      return nil
    }
    switch position {
    case .h(let h):
      guard let previousHIndex = $h.subscriptableIndex(before: h) else {
        return finalPositionBeforeH()
      }
      return .h(previousHIndex)
    case .g(let g):
      guard let previousGIndex = $g.subscriptableIndex(before: g) else {
        return finalPositionBeforeG()
      }
      return .g(previousGIndex)
    case .f(let f):
      guard let previousFIndex = $f.subscriptableIndex(before: f) else {
        return finalPositionBeforeF()
      }
      return .f(previousFIndex)
    case .e(let e):
      guard let previousEIndex = $e.subscriptableIndex(before: e) else {
        return finalPositionBeforeE()
      }
      return .e(previousEIndex)
    case .d(let d):
      guard let previousDIndex = $d.subscriptableIndex(before: d) else {
        return finalPositionBeforeD()
      }
      return .d(previousDIndex)
    case .c(let c):
      guard let previousCIndex = $c.subscriptableIndex(before: c) else {
        return finalPositionBeforeC()
      }
      return .c(previousCIndex)
    case .b(let b):
      guard let previousBIndex = $b.subscriptableIndex(before: b) else {
        return finalPositionBeforeB()
      }
      return .b(previousBIndex)
    case .a(let a):
      guard let previousAIndex = $a.subscriptableIndex(before: a) else {
        return finalPositionBeforeA()
      }
      return .a(previousAIndex)
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain8CollectionStorage - Position Retreat Support
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage {
  
  @usableFromInline
  internal func finalPositionBeforeA() -> Position? {
    nil
  }
  
  @usableFromInline
  internal func finalPositionBeforeB() -> Position? {
    Position.finalNonNil(
      $a.finalSubscriptableIndex,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil
    )
  }

  @usableFromInline
  internal func finalPositionBeforeC() -> Position? {
    Position.finalNonNil(
      $a.finalSubscriptableIndex,
      $b.finalSubscriptableIndex,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil
    )
  }

  @usableFromInline
  internal func finalPositionBeforeD() -> Position? {
    Position.finalNonNil(
      $a.finalSubscriptableIndex,
      $b.finalSubscriptableIndex,
      $c.finalSubscriptableIndex,
      nil,
      nil,
      nil,
      nil,
      nil
    )
  }

  @usableFromInline
  internal func finalPositionBeforeE() -> Position? {
    Position.finalNonNil(
      $a.finalSubscriptableIndex,
      $b.finalSubscriptableIndex,
      $c.finalSubscriptableIndex,
      $d.finalSubscriptableIndex,
      nil,
      nil,
      nil,
      nil
    )
  }

  @usableFromInline
  internal func finalPositionBeforeF() -> Position? {
    Position.finalNonNil(
      $a.finalSubscriptableIndex,
      $b.finalSubscriptableIndex,
      $c.finalSubscriptableIndex,
      $d.finalSubscriptableIndex,
      $e.finalSubscriptableIndex,
      nil,
      nil,
      nil
    )
  }

  @usableFromInline
  internal func finalPositionBeforeG() -> Position? {
    Position.finalNonNil(
      $a.finalSubscriptableIndex,
      $b.finalSubscriptableIndex,
      $c.finalSubscriptableIndex,
      $d.finalSubscriptableIndex,
      $e.finalSubscriptableIndex,
      $f.finalSubscriptableIndex,
      nil,
      nil
    )
  }

  @usableFromInline
  internal func finalPositionBeforeH() -> Position? {
    Position.finalNonNil(
      $a.finalSubscriptableIndex,
      $b.finalSubscriptableIndex,
      $c.finalSubscriptableIndex,
      $d.finalSubscriptableIndex,
      $e.finalSubscriptableIndex,
      $f.finalSubscriptableIndex,
      $g.finalSubscriptableIndex,
      nil
    )
  }

  @inlinable
  internal func finalPosition(before position: Arity8Position) -> Position? {
    switch position {
    case .a:
      finalPositionBeforeA()
    case .b:
      finalPositionBeforeB()
    case .c:
      finalPositionBeforeC()
    case .d:
      finalPositionBeforeD()
    case .e:
      finalPositionBeforeE()
    case .f:
      finalPositionBeforeF()
    case .g:
      finalPositionBeforeG()
    case .h:
      finalPositionBeforeH()
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain8CollectionStorage - With Derivation
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage {
  
  
  @inlinable
  internal func with(a: A) -> Self {
    withMutatedAlgebraicProductRepresentation {
      $0.a = a
    }
  }
  
  @inlinable
  internal func with(b: B) -> Self {
    withMutatedAlgebraicProductRepresentation {
      $0.b = b
    }
  }

  @inlinable
  internal func with(c: C) -> Self {
    withMutatedAlgebraicProductRepresentation {
      $0.c = c
    }
  }

  @inlinable
  internal func with(d: D) -> Self {
    withMutatedAlgebraicProductRepresentation {
      $0.d = d
    }
  }

  @inlinable
  internal func with(e: E) -> Self {
    withMutatedAlgebraicProductRepresentation {
      $0.e = e
    }
  }

  @inlinable
  internal func with(f: F) -> Self {
    withMutatedAlgebraicProductRepresentation {
      $0.f = f
    }
  }

  @inlinable
  internal func with(g: G) -> Self {
    withMutatedAlgebraicProductRepresentation {
      $0.g = g
    }
  }

  @inlinable
  internal func with(h: H) -> Self {
    withMutatedAlgebraicProductRepresentation {
      $0.h = h
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: - Value-Exposure
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage {
  
  @usableFromInline
  internal typealias AlgebraicProductRepresentation = InlineProduct8<A,B,C,D,E,F,G,H>
  
  @inlinable
  internal var algebraicProductRepresentation: AlgebraicProductRepresentation {
    AlgebraicProductRepresentation(
      tupleRepresentation: constituentTuple
    )
  }
  
  @inlinable
  internal convenience init(algebraicProductRepresentation: AlgebraicProductRepresentation) {
    self.init(constituentTuple: algebraicProductRepresentation.tupleRepresentation)
  }

  // TODO: any way to pull the cached properties over for the unchanged properties?
  @inlinable
  internal func withMutatedAlgebraicProductRepresentation(
    _ mutation: (inout AlgebraicProductRepresentation) throws -> Void
  ) rethrows -> Self {
    var clone = algebraicProductRepresentation
    try mutation(&clone)
    
    return Self(algebraicProductRepresentation: clone)
  }

}

// -------------------------------------------------------------------------- //
// MARK: Chain8CollectionStorage - Sendable
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage: @unchecked Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable,
F: Sendable,
G: Sendable,
H: Sendable
{ }

// -------------------------------------------------------------------------- //
// MARK: Chain8CollectionStorage - Equatable
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage : Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable,
F: Equatable,
G: Equatable,
H: Equatable
{
  
  @inlinable
  internal static func ==(
    lhs: Chain8CollectionStorage<A,B,C,D,E,F,G,H>,
    rhs: Chain8CollectionStorage<A,B,C,D,E,F,G,H>
  ) -> Bool {
    lhs === rhs
    ||
    lhs.algebraicProductRepresentation == rhs.algebraicProductRepresentation
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Hashable
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage : Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable,
F: Hashable,
G: Hashable,
H: Hashable
{
  
  @inlinable
  internal func hash(into hasher: inout Hasher) {
    algebraicProductRepresentation.hash(into: &hasher)
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: - Codable
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage : Codable
where
A: Codable,
B: Codable,
C: Codable,
D: Codable,
E: Codable,
F: Codable,
G: Codable,
H: Codable
{
  
  @inlinable
  internal func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(algebraicProductRepresentation)
  }
  
  @inlinable
  internal convenience init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.init(
      algebraicProductRepresentation: try container.decode(
        AlgebraicProductRepresentation.self
      )
    )
  }
  
}
