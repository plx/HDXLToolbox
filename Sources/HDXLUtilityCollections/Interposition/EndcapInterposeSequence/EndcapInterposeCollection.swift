import Foundation
import HDXLEssentialPrecursors

/// Convenience when you need to require ``EndcapInterposeSequence`` to conform to ``Collection``.
public typealias EndcapInterposeCollection<Intro,Outro,Base> = EndcapInterposeSequence<Intro,Outro,Base> where Base: Collection

/// Convenience when you need to require ``EndcapInterposeSequence`` to conform to ``BidirectionalCollection``.
public typealias EndcapInterposeBidirectionalCollection<Intro,Outro,Base> = EndcapInterposeSequence<Intro,Outro,Base> where Base: BidirectionalCollection

/// Convenience when you need to require ``EndcapInterposeSequence`` to conform to ``RandomAccessCollection``.
public typealias EndcapInterposeRandomAccessCollection<Intro,Outro,Base> = EndcapInterposeSequence<Intro,Outro,Base> where Base: RandomAccessCollection
