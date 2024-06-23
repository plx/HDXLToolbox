import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: - `contains(_:)`
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage where Element: Equatable {
  
  @inlinable
  internal func contains(_ element: Element) -> Bool {
    anyAreTrue(
      a.contains(element),
      b.contains(element),
      c.contains(element),
      d.contains(element),
      e.contains(element),
      f.contains(element),
      g.contains(element),
      h.contains(element)
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionStorage - `min()`, `max()`
// -------------------------------------------------------------------------- //

extension Chain8CollectionStorage where Element: Comparable {
  
  @inlinable
  internal func min() -> Element? {
    possibleMinimum(
      a.min(),
      b.min(),
      c.min(),
      d.min(),
      e.min(),
      f.min(),
      g.min(),
      h.min()
    )
  }
  
  @inlinable
  internal func max() -> Element? {
    possibleMaximum(
      a.max(),
      b.max(),
      c.max(),
      d.max(),
      e.max(),
      f.max(),
      g.max(),
      h.max()
    )
  }
  
}
