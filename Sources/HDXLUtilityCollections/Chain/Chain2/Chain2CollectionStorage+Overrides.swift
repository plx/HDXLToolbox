import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: - `contains(_:)`
// -------------------------------------------------------------------------- //

extension Chain2CollectionStorage where Element: Equatable {
  
  @inlinable
  internal func contains(_ element: Element) -> Bool {
    return (
      a.contains(element)
      ||
      b.contains(element)
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionStorage - `min()`, `max()`
// -------------------------------------------------------------------------- //

extension Chain2CollectionStorage where Element: Comparable {
  
  @inlinable
  internal func min() -> Element? {
    return weakMinimum(
      a.min(),
      b.min()
    )
  }
  
  @inlinable
  internal func max() -> Element? {
    weakMaximum(
      a.max(),
      b.max()
    )
  }
  
}
