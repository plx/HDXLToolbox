import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Chain8Collection - `contains(_:)`
// -------------------------------------------------------------------------- //

extension Chain8Collection where Element: Equatable {

  @inlinable
  public func contains(_ element: Element) -> Bool {
    storage.contains(element)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - `min()`, `max()`
// -------------------------------------------------------------------------- //

extension Chain8Collection where Element: Comparable {
  
  @inlinable
  public func min() -> Element? {
    storage.min()
  }
  
  @inlinable
  public func max() -> Element? {
    storage.max()
  }
  
}
