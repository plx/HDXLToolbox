import Foundation

extension KeyedSet {
  
  @inlinable
  public func restricted(to keySet: Set<Key>) -> Self {
    Self(
      storage: storage.restricted(
        to: keySet
      )
    )
  }

  @inlinable
  public func restricted(to keys: some Sequence<Key>) -> Self {
    Self(
      storage: storage.restricted(
        to: keys
      )
    )
  }

}
