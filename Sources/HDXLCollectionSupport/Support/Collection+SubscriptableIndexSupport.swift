import Foundation
import HDXLEssentialPrecursors

extension Collection {
  
  @inlinable
  package var firstSubscriptableIndex: Index? {
    switch isEmpty {
    case true:
      nil
    case false:
      startIndex
    }
  }
  
  @inlinable
  package var finalSubscriptableIndex: Index? {
    switch isEmpty {
    case true:
      nil
    case false:
      index(
        startIndex,
        offsetBy: count - 1
      )
    }
  }
  
  @inlinable
  package func subscriptableIndex(after i: Index) -> Index? {
    guard i < endIndex else {
      return nil
    }
    let destination = index(after: i)
    return destination == endIndex ? nil : destination
  }
  
  @inlinable
  package func formSubscriptableIndex(
    after index: inout Index
  ) -> Bool {
    precondition(canSubscript(index: index))
    formIndex(
      after: &index
    )
    return canSubscript(
      index: index
    )
  }

  @inlinable
  package func canSubscript(index: Index) -> Bool {
    indices.contains(index)
  }

  @inlinable
  package func subscriptableIndex(
    _ i: Index,
    offsetBy distance: Int
  ) -> IndexPositionStorageMovementAttemptDestination<Index> {
    precondition(canSubscript(index: i))
    let result = index(
      i,
      offsetBy: distance
    )
    switch result <=> endIndex {
    case .orderedAscending:
      guard result >= startIndex else {
        return .misnavigation
      }
      return .success(result)
    case .orderedSame:
      return .becameEnd
    case .orderedDescending:
      return .misnavigation
    }
  }
  
  @inlinable
  internal func formSubscriptableIndex(
    _ index: inout Index,
    offsetBy distance: Int
  ) -> IndexPositionStorageMovementAttemptResult {
    precondition(self.canSubscript(index: index))
    guard distance != 0 else {
      return .success
    }
    self.formIndex(
      &index,
      offsetBy: distance
    )
    precondition((self.startIndex..<self.endIndex).contains(index))
    // ^ for some types we can't feel confident we won't grossly overshoot/undershoot
    switch index <=> self.endIndex {
    case .orderedAscending:
      guard index >= self.startIndex else {
        return .misnavigation
      }
      return .success
    case .orderedSame:
      return .becameEnd
    case .orderedDescending:
      return .misnavigation
    }
  }

}
