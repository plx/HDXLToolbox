import HDXLEssentialPrecursors

@usableFromInline
package protocol InternalPositionBidirectionalCollection : InternalPositionCollection, BidirectionalCollection {
    
  func internalPosition(
    before position: InternalPosition
  ) -> InternalPosition?
  
}

extension InternalPositionBidirectionalCollection {
  
  @inlinable
  public func index(before i: Index) -> Index {
    switch i.storage {
    case .position(let position):
      guard
        let previousPosition = internalPosition(
          before: position
        )
      else {
        preconditionFailure(
          """
          Attempted to go back from the `startIndex` on \(String(reflecting: self))!
          """
        )
      }
      
      return .position(previousPosition)
    case .endIndex:
      guard let lastInternalPosition else {
        preconditionFailure(
          """
          Attempted to go back from the `endIndex` in empty-collection \(String(reflecting: self))!
          """
        )
      }
      
      return .position(lastInternalPosition)
    }
  }
  
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
