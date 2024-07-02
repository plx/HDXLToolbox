import HDXLEssentialPrecursors

@usableFromInline
package protocol InternalPositionRandomAccessCollection: InternalPositionBidirectionalCollection, RandomAccessCollection {
  }

extension InternalPositionRandomAccessCollection {
  
  @inlinable
  public var startIndex: Index { _startIndex }

  @inlinable
  public var endIndex: Index { _endIndex }
    
  @inlinable
  public func distance(
    from start: Index,
    to end: Index
  ) -> Int {
    _distance(
      from: start,
      to: end
    )
  }

  @inlinable
  public func index(after i: Index) -> Index {
    _index(after: i)
  }

  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int
  ) -> Index {
    _index(
      i,
      offsetBy: distance
    )
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int,
    limitedBy limit: Index
  ) -> Index? {
    _index(
      i,
      offsetBy: distance,
      limitedBy: limit
    )
  }

}
