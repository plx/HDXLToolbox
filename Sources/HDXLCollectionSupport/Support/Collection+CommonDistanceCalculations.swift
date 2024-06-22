import Foundation
import HDXLEssentialPrecursors

extension Collection {
  
  /// Convenience for the common query "how far from `startIndex` to `index`?"
  @inlinable
  package func distanceFromStart(to index: Index) -> Int {
    distance(
      from: startIndex,
      to: index
    )
  }

  /// Convenience for the common query "how far from `index` to `startIndex`?"
  @inlinable
  package func distanceToStart(from index: Index) -> Int {
    distance(
      from: index,
      to: startIndex
    )
  }
  

  /// Convenience for the common query "how far from `index` to the `endIndex`?"
  @inlinable
  package func distanceToEnd(from index: Index) -> Int {
    distance(
      from: index,
      to: endIndex
    )
  }

  /// Convenience for the common query "how far from `endIndex` to `index`?"
  @inlinable
  package func distanceFromEnd(to index: Index) -> Int {
    distance(
      from: endIndex,
      to: index
    )
  }

}
