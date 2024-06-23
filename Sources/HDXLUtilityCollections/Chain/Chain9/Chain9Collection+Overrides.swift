import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Chain9Collection - `contains(_:)`
// -------------------------------------------------------------------------- //

extension Chain9Collection where Element: Equatable {

  @inlinable
  public func contains(_ element: Element) -> Bool {
    storage.contains(element)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection - `min()`, `max()`
// -------------------------------------------------------------------------- //

extension Chain9Collection where Element: Comparable {
  
  @inlinable
  public func min() -> Element? {
    storage.min()
  }
  
  @inlinable
  public func max() -> Element? {
    storage.max()
  }
  
}
