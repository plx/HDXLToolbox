import HDXLEssentialPrecursors

@usableFromInline
package enum InternalPositionNavigationOutcome<InternalPosition> {
  case success(InternalPosition)
  case reachedEndIndex
  case wentPastEndIndex
  case wentBeforeStartIndex
}

@usableFromInline
package protocol InternalPositionCollection : Collection
where
Index: PositionIndexStorageWrapper<InternalPosition>
{
  
  associatedtype InternalPosition: Comparable
  
  var firstInternalPosition: InternalPosition? { get }
  var lastInternalPosition: InternalPosition? { get }
  
  subscript(internalPosition: InternalPosition) -> Element { get }
  
  func index(forInternalPosition position: InternalPosition) -> Index
  func internalPosition(forIndex index: Index) -> InternalPosition?

  func distance(
    from start: InternalPosition,
    to end: InternalPosition
  ) -> Int
  
  func internalPosition(
    after position: InternalPosition
  ) -> InternalPosition?
  
  func internalPosition(
    _ position: InternalPosition,
    offsetBy distance: Int
  ) -> InternalPositionNavigationOutcome<InternalPosition>
  
}

extension InternalPositionCollection {
  
  @inlinable
  package func index(forInternalPosition position: InternalPosition) -> Index {
    Index(position: position)
  }
  
  @inlinable
  package func internalPosition(
    forIndex index: Index
  ) -> InternalPosition? {
    switch index.storage {
    case .position(let position):
      position
    case .endIndex:
      nil
    }
  }
  
  @inlinable
  package func extractIndex(
    from navigationOutcome: InternalPositionNavigationOutcome<InternalPosition>,
    explanation: @autoclosure () -> String,
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
  ) -> Index {
    switch navigationOutcome {
    case .success(let internalPosition):
      .position(internalPosition)
    case .reachedEndIndex:
      .endIndex
    case .wentPastEndIndex:
      preconditionFailure(
        """
        Navigation failure: overshot the end index.
        
        - `self`: \(String(reflecting: self))
        - `explanation`: \(explanation())
        - `function`: \(function)
        - `file`: \(file)
        - `line`: \(line)
        - `column`: \(column)
        """,
        file: file,
        line: line
      )
    case .wentBeforeStartIndex:
      preconditionFailure(
        """
        Navigation failure: went past the start index.
        
        - `self`: \(String(reflecting: self))
        - `explanation`: \(explanation())
        - `function`: \(function)
        - `file`: \(file)
        - `line`: \(line)
        - `column`: \(column)
        """,
        file: file,
        line: line
      )
    }
  }
  
}
extension InternalPositionCollection {
  
  @inlinable
  package var _startIndex: Index {
    switch firstInternalPosition {
    case .some(let position):
      .position(position)
    case .none:
      endIndex
    }
  }
  
  @inlinable
  public var _endIndex: Index {
    .endIndex
  }
  
//  @inlinable
//  package subscript(_index index: Index) -> Element {
//    switch index.storage {
//    case .position(let internalPosition):
//      return self[internalPosition]
//    case .endIndex:
//      preconditionFailure(
//        """
//        Attempted to subscript the `endIndex`!
//
//        - `self`: \(String(reflecting: self))
//        - `index`: \(String(reflecting: index))
//        """
//      )
//    }
//  }
  
  @inlinable
  package func _distance(
    from start: Index,
    to end: Index
  ) -> Int {
    guard start != end else {
      return 0
    }
    
    switch (start.storage, end.storage) {
    case (.endIndex, .endIndex):
      // first easy case: this is obviously zero
      // note: technically we shouldn't ever hit this case
      // b/c it's handled by the bail-out early-return...
      // ...if Swift ever gets an `@unlikely`-style annotation
      // would be good to annotate this with that
      return 0
    case (.position(let startPosition), .position(let endPosition)):
      // other easy case: we forward to our internal-position distance func
      return distance(
        from: startPosition,
        to: endPosition
      )
    case (.position(let startPosition), .endIndex):
      // first "tricky" case, as our distance here decomposes as
      // the sum of two discrete navigation steps:
      //
      // 1. the distance from `startPosition` to the last internal position
      // 2. the distance from the last internal position to the end index (always 1)
      guard let finalPosition = lastInternalPosition else {
        preconditionFailure(
          """
          Discovered internal inconsistency during call to `distance(from:to:)`!
          
          On the one hand, our `start` corresponded to a subscriptable internal position,
          which is only possible for non-empty collections.
          
          On the other hand, we got `nil` as our `lastInternalPosition`, which is only
          possible for empty collections.
          
          - `self`: \(String(reflecting: self))
          - `start`: \(String(reflecting: start))
          - `end`: \(String(reflecting: end))
          """
        )
      }

      return distance(
        from: startPosition,
        to: finalPosition
      ) + 1
    case (.endIndex, .position(let endPosition)):
      guard let finalPosition = lastInternalPosition else {
        preconditionFailure(
          """
          Discovered internal inconsistency during call to `distance(from:to:)`!
          
          On the one hand, our `end` corresponded to a subscriptable internal position,
          which is only possible for non-empty collections.
          
          On the other hand, we got `nil` as our `lastInternalPosition`, which is only
          possible for empty collections.
          
          - `self`: \(String(reflecting: self))
          - `start`: \(String(reflecting: start))
          - `end`: \(String(reflecting: end))
          """
        )
      }
      
      // The -1 is b/c we are
      return distance(
        from: finalPosition,
        to: endPosition
      ) - 1
    }
  }

  @inlinable
  package func _index(after i: Index) -> Index {
    guard case .position(let position) = i.storage else {
      preconditionFailure(
        """
        Attempted to advance the `endIndex` on \(String(reflecting: self))!
        """
      )
    }
    
    switch internalPosition(after: position) {
    case .some(let nextPosition):
      return .position(nextPosition)
    case .none:
      return .endIndex
    }
  }
    
  @inlinable
  package func _index(
    _ i: Index,
    offsetBy distance: Int
  ) -> Index {
    guard distance != 0 else {
      return i
    }
    
    switch i.storage {
    case .position(let position):
      return extractIndex(
        from: internalPosition(
          position,
          offsetBy: distance
        ),
        explanation: "offsetting position \(position) by \(distance)"
      )
    case .endIndex:
      guard distance < 0 else {
        preconditionFailure(
          """
          Attempted to advance by \(distance) from the `endIndex` on \(String(reflecting: self))!
          """
        )
      }
      guard let lastInternalPosition else {
        preconditionFailure(
          """
          Attempted to navigate by \(distance) (from the `endIndex`) within the empty-collection \(String(reflecting: self))!
          """
        )
      }
      
      // the `+1` factor is how we account for having already moved from the
      // end index to the final internal position; think of it this way:
      //
      // - `goal == endIndex - distance`
      // - `goal == lastPosition - (distance - 1)`
      // - `goal == lastPosition - distance + 1`
      //
      return extractIndex(
        from: internalPosition(
          lastInternalPosition,
          offsetBy: distance + 1
        ),
        explanation: "offsetting endIndex by \(distance)"
      )
    }
  }
  
  @inlinable
  package func _index(
    _ i: Index,
    offsetBy distance: Int,
    limitedBy limit: Index
  ) -> Index? {
    guard i != limit else { return i }
    
    switch 0 <=> distance {
    case .orderedSame:
      return i
    case .orderedAscending:
      assert(distance > 0)
      // ^ we're going forward
      let distanceToLimit = self.distance(
        from: i,
        to: limit
      )
      
      assert(distanceToLimit != 0)
      
      let shouldNavigate = distanceToLimit < 0 || distance <= distanceToLimit
      switch shouldNavigate {
      case true:
        return index(
          i,
          offsetBy: distance
        )
      case false:
        return nil
      }
    case .orderedDescending:
      assert(distance < 0)
      // ^ we're going backward
      let distanceToLimit = self.distance(
        from: i,
        to: limit
      )
      
      assert(distanceToLimit != 0)
      
      let shouldNavigate = distanceToLimit > 0 || distanceToLimit <= distance
      switch shouldNavigate {
      case true:
        return index(
          i,
          offsetBy: distance
        )
      case false:
        return nil
      }
    }
  }

}

extension InternalPositionCollection {
  
  @inlinable
  public var startIndex: Index { _startIndex }

  @inlinable
  public var endIndex: Index { _endIndex }
  
  @inlinable
  public subscript(index: Index) -> Element {
    switch index.storage {
    case .position(let internalPosition):
      return self[internalPosition]
    case .endIndex:
      preconditionFailure(
        """
        Attempted to subscript the `endIndex`!
        
        - `self`: \(String(reflecting: self))
        - `index`: \(String(reflecting: index))
        """
      )
    }
  }
  
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
