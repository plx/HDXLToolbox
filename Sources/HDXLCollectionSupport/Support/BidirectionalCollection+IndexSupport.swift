import Foundation

extension BidirectionalCollection {

  @inlinable
  package func subscriptableIndex(before i: Index) -> Index? {
    guard startIndex < i else {
      return nil
    }
    return index(before: i)
  }

}
