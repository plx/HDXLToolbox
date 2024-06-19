import Foundation

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
  package func canSubscript(index: Index) -> Bool {
    indices.contains(index)
  }

}
