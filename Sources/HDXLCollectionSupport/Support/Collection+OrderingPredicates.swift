import Foundation
import HDXLEssentialPrecursors

extension Collection where Element:Comparable {
  
  @inlinable
  internal func allAdjacentPairsSatisfy(
    _ predicate: (Element, Element) throws -> Bool
  ) rethrows -> Bool {
    guard count > 1 else {
      return true
    }
    
    return try zip(
      self,
      lazy.dropFirst()
    ).allSatisfy(predicate)
  }
  
  @inlinable
  package var isOrderedAscending: Bool {
    allAdjacentPairsSatisfy { $0 <= $1 }
  }
  
  @inlinable
  package var isOrderedStrictlyAscending: Bool {
    allAdjacentPairsSatisfy { $0 < $1 }
  }
  
  @inlinable
  package var isOrderedDescending: Bool {
    allAdjacentPairsSatisfy { $0 >= $1 }
  }
  
  @inlinable
  package var isOrderedStrictlyDescending: Bool {
    allAdjacentPairsSatisfy { $0 > $1 }
  }
  
}
