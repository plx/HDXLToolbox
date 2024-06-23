import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - `contains(_:)`
// -------------------------------------------------------------------------- //

extension Chain2Collection where Element: Equatable {

  @inlinable
  public func contains(_ element: Element) -> Bool {
    storage.contains(element)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - `min()`, `max()`
// -------------------------------------------------------------------------- //

extension Chain2Collection where Element: Comparable {
  
  @inlinable
  public func min() -> Element? {
    storage.min()
  }
  
  @inlinable
  public func max() -> Element? {
    storage.max()
  }
  
}
