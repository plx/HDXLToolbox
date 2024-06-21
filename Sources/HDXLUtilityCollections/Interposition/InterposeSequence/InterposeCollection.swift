import Foundation
import HDXLEssentialPrecursors

/// Convenience when you need to require ``InterposeSequence`` to conform to ``Collection``.
public typealias InterposeCollection<Base> = InterposeSequence<Base> where Base: Collection

/// Convenience when you need to require ``InterposeSequence`` to conform to ``BidirectionalCollection``.
public typealias InterposeBidirectionalCollection<Base> = InterposeSequence<Base> where Base: BidirectionalCollection

/// Convenience when you need to require ``InterposeSequence`` to conform to ``RandomAccessCollection``.
public typealias InterposeRandomAccessCollection<Base> = InterposeSequence<Base> where Base: RandomAccessCollection
