import HDXLEssentialPrecursors

@usableFromInline
package protocol LinearizableInternalPositionCollection : InternalPositionCollection {
  
  func linearPosition(forInternalPosition internalPosition: InternalPosition) -> Int
  func internalPosition(forLinearPosition linearPosition: Int) -> InternalPosition?
}

extension LinearizableInternalPositionCollection {
  
  @inlinable
  package var validLinearPositions: Range<Int> {
    0..<count
  }

  @inlinable
  package func unsafeInternalPosition(
    forPresumptivelyValidLinearPosition linearPosition: Int,
    explanation: @autoclosure () -> String,
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
  ) -> InternalPosition {
    precondition(
      validLinearPositions.contains(linearPosition),
      """
      Called `unsafeInternalPosition(forPresumptivelyValidLinearPosition:)` on an actually-invalid linear position!

      - `self`: \(String(reflecting: self))
      - `explanation`: \(explanation())
        - `linearPosition`: \(linearPosition)
        - `validLinearPositions`: \(validLinearPositions)
      - `function`: \(function)
      - `file`: \(file)
      - `line`: \(line)
      - `column`: \(column)
      """,
      file: file,
      line: line
    )
    
    guard let internalPosition = internalPosition(forLinearPosition: linearPosition) else {
      preconditionFailure(
        """
        Anomalous linear-index to internal-position conversion failure!
        
        On the one hand, we have a linear position \(linearPosition) within the valid range \(validLinearPositions),
        but on the other hand we (somehow) couldn't convert it back into an internal position.
        
        - `self`: \(String(reflecting: self))
        - `explanation`: \(explanation())
        - `linearPosition`: \(linearPosition)
        - `validLinearPositions`: \(validLinearPositions)
        - `function`: \(function)
        - `file`: \(file)
        - `line`: \(line)
        - `column`: \(column)
        """
      )

    }

    return internalPosition
  }

  @inlinable
  package func distance(
    from start: InternalPosition,
    to end: InternalPosition
  ) -> Int {
    linearPosition(forInternalPosition: end) - linearPosition(forInternalPosition: start)
  }
  
  @inlinable
  package func internalPosition(
    after position: InternalPosition
  ) -> InternalPosition? {
    internalPosition(
      forLinearPosition: 1 + linearPosition(
        forInternalPosition: position
      )
    )
  }
  
  @inlinable
  package func internalPosition(
    _ position: InternalPosition,
    offsetBy distance: Int
  ) -> InternalPositionNavigationOutcome<InternalPosition> {
    let initialLinearPosition = linearPosition(forInternalPosition: position)
    let destinationLinearPosition = initialLinearPosition + distance
    let count = count
    if destinationLinearPosition < 0 {
      return .wentBeforeStartIndex
    } else if destinationLinearPosition > count {
      return .wentPastEndIndex
    } else if destinationLinearPosition == count {
      return .reachedEndIndex
    } else {
      return .success(
        unsafeInternalPosition(
          forPresumptivelyValidLinearPosition: destinationLinearPosition,
          explanation: "Offsetting \(String(reflecting: position)) (linear position: \(initialLinearPosition)) by \(distance) arrived-at (valid) linear position \(destinationLinearPosition)."
        )
      )
    }
  }
  
}
