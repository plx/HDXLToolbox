import Foundation
import HDXLEssentialPrecursors

extension Collection {
    
  @inlinable
  package func locateFinalSubscriptableIndex(
    assumingCount count: Int
  ) -> Index? {
    guard count > 0 else {
      return nil
    }
    return index(
      startIndex,
      offsetBy: count - 1
    )
  }
    
}
