import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: KeyedArray - Sequence Access
// -------------------------------------------------------------------------- //

/// ### Sequence Access
///
/// Exposes various sequences derived from the contents of a keyed array.
extension KeyedArray {
  
  /// Returns a collection all the keys in `self`.
  @inlinable
  public var keys: some Collection<Key> {
    storage.keys
  }
  
  /// Returns a collection all the value-arrays (e.g. `[Value]`s)  in `self`.
  @inlinable
  public var valueArrays: some Collection<[Value]> {
    storage.values
  }
  
  
}
