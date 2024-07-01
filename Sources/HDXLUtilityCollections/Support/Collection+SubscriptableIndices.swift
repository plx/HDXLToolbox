import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

extension Collection {
    
  @inlinable
  internal func locateFinalSubscriptableIndex(assumingCount count: Int) -> Index? {
    guard count > 0 else {
      return nil
    }
    return index(
      startIndex,
      offsetBy: count - 1
    )
  }
  
  @inlinable
  func canSubscript(index: Index) -> Bool {
    startIndex <= index && index < endIndex
  }
  
  @inlinable
  func subscriptableIndex(after index: Index) -> Index? {
    precondition(canSubscript(index: index))
    let nextIndex = self.index(after: index)
    guard nextIndex < endIndex else {
      return nil
    }
    return nextIndex
  }
  
  @inlinable
  func formSubscriptableIndex(after index: inout Index) -> Bool {
    precondition(canSubscript(index: index))
    formIndex(
      after: &index
    )
    return canSubscript(
      index: index
    )
  }
  
  @inlinable
  internal func subscriptableIndex(
    _ index: Index,
    offsetBy distance: Int
  ) -> IndexPositionStorageMovementAttemptDestination<Index> {
    precondition(canSubscript(index: index))
    let result = self.index(
      index,
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
    precondition(canSubscript(index: index))
    guard distance != 0 else {
      return .success
    }
    formIndex(
      &index,
      offsetBy: distance
    )
    precondition((startIndex..<endIndex).contains(index))
    // ^ for some types we can't feel confident we won't grossly overshoot/undershoot
    switch index <=> endIndex {
    case .orderedAscending:
      guard index >= startIndex else {
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

public extension BidirectionalCollection {
  
  @inlinable
  func subscriptableIndex(before index: Index) -> Index? {
    guard index > startIndex else {
      return nil
    }
    return self.index(
      before: index
    )
  }
  
  @inlinable
  func formSubscriptableIndex(before index: inout Index) -> Bool {
    guard index > startIndex else {
      return false
    }
    formIndex(before: &index)
    return true
  }
  
}
