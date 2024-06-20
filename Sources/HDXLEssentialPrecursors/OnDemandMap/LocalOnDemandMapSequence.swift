import Foundation

public typealias LocalOnDemandMapCollection<Element, Base> = LocalOnDemandMapSequence<Element, Base> where Base: Collection
public typealias LocalOnDemandMapBidirectionalCollection<Element, Base> = LocalOnDemandMapSequence<Element, Base> where Base: BidirectionalCollection
public typealias LocalOnDemandMapRandomAccessCollection<Element, Base> = LocalOnDemandMapSequence<Element, Base> where Base: RandomAccessCollection

extension Sequence {
  
  @inlinable
  public func localOnDemandMap<R>(_ transformation: @escaping (Element) -> R) -> LocalOnDemandMapSequence<R, Self> {
    LocalOnDemandMapSequence(base: self, transformation: transformation)
  }
  
}

@frozen
public struct LocalOnDemandMapSequence<Element, Base> where Base: Sequence {
  
  public let base: Base
  
  @usableFromInline
  internal let transformation: (Base.Element) -> Element
    
  @inlinable
  internal init(
    base: Base,
    transformation: @escaping (Base.Element) -> Element
  ) {
    self.base = base
    self.transformation = transformation
  }
  
}

extension LocalOnDemandMapSequence: Sequence {
  
  public typealias Iterator = LocalOnDemandMapSequenceIterator<Element, Base.Iterator>
  
  @inlinable
  public var underestimatedCount: Int {
    base.underestimatedCount
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(
      base: base.makeIterator(),
      transformation: transformation
    )
  }
  
}

extension LocalOnDemandMapSequence: Collection where Base: Collection {
  
  public typealias Index = LocalOnDemandMapSequenceIndex<Element, Base>
  
  @inlinable
  public var isEmpty: Bool {
    base.isEmpty
  }
  
  @inlinable
  public var count: Int {
    base.count
  }
  
  @inlinable
  public var startIndex: Index {
    Index(index: base.startIndex)
  }

  @inlinable
  public var endIndex: Index {
    Index(index: base.endIndex)
  }
  
  @inlinable
  public subscript(index: Index) -> Element {
    transformation(base[index.index])
  }
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index
  ) -> Int {
    base.distance(
      from: start.index,
      to: end.index
    )
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    Index(
      index: base.index(
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
      index: base.index(
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
      possibleIndex: base.index(
        i.index,
        offsetBy: distance,
        limitedBy: limit.index
      )
    )
  }
  
  @inlinable
  public func formIndex(after i: inout Index) {
    base.formIndex(after: &i.index)
  }
  
  @inlinable
  public func formIndex(
    _ i: inout Index,
    offsetBy distance: Int
  ) {
    base.formIndex(
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
    base.formIndex(
      &i.index,
      offsetBy: distance,
      limitedBy: limit.index
    )
  }

}

extension LocalOnDemandMapSequence: BidirectionalCollection where Base: BidirectionalCollection {
  
  @inlinable
  public func index(before i: Index) -> Index {
    Index(
      index: base.index(
        before: i.index
      )
    )
  }

  @inlinable
  public func formIndex(before i: inout Index) {
    base.formIndex(before: &i.index)
  }

}

extension LocalOnDemandMapSequence: RandomAccessCollection where Base: RandomAccessCollection {}

@frozen
public struct LocalOnDemandMapSequenceIndex<Element, Base> where Base: Collection {
  
  @usableFromInline
  internal typealias Index = Base.Index
  
  @usableFromInline
  internal var index: Index
  
  @inlinable
  internal init(index: Index) {
    self.index = index
  }

  @inlinable
  internal init?(possibleIndex: Index?) {
    guard let index = possibleIndex else {
      return nil
    }
    self.init(index: index)
  }

}

extension LocalOnDemandMapSequenceIndex: Equatable { }
extension LocalOnDemandMapSequenceIndex: Hashable where Base.Index: Hashable { }
extension LocalOnDemandMapSequenceIndex: Comparable {
  
  @inlinable
  public static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.index < rhs.index
  }
  
}

@frozen
public struct LocalOnDemandMapSequenceIterator<Element, Base>: IteratorProtocol where Base:IteratorProtocol {
  @usableFromInline
  internal var base: Base
  
  @usableFromInline
  internal let transformation: (Base.Element) -> Element
  
  @inlinable
  internal init(
    base: Base,
    transformation: @escaping (Base.Element) -> Element
  ) {
    self.base = base
    self.transformation = transformation
  }

  @inlinable
  public mutating func next() -> Element? {
    switch base.next() {
    case .some(let baseElement):
      transformation(baseElement)
    case .none:
      nil
    }
  }

}
