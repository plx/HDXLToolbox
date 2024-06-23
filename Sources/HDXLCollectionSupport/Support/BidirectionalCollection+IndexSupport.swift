import Foundation
import HDXLEssentialPrecursors

extension BidirectionalCollection {

  @inlinable
  package func subscriptableIndex(before i: Index) -> Index? {
    guard startIndex < i else {
      return nil
    }
    return index(before: i)
  }

  @inlinable
  package func formSubscriptableIndex(before index: inout Index) -> Bool {
    guard index > startIndex else {
      return false
    }
    formIndex(before: &index)
    return true
  }
  

}
