import Foundation

extension Dictionary {
  
  @inlinable
  internal var allKeys: [Key] {
    [Key](keys)
  }
  
  @inlinable
  internal var keySet: Set<Key> {
    Set<Key>(keys)
  }
  
  @inlinable
  internal func keysSatisfying(
    _ predicate: (Key, Value) throws -> Bool
  ) rethrows -> some Sequence<Key> {
    try lazy
      .filter(predicate)
      .map(\.key)
  }

  @inlinable
  internal func keysForValuesSatisfying(
    _ predicate: (Value) throws -> Bool
  ) rethrows -> some Sequence<Key> {
    try lazy
      .filter { (_, value) in try predicate(value) }
      .map(\.key)
  }

  @inlinable
  internal func restricted(to keySet: Set<Key>) -> Self {
    Dictionary(
      uniqueKeysWithValues: lazy.filter { (key, _) in
        keySet.contains(key)
      }
    )
  }

  @inlinable
  internal func restricted(to keys: some Sequence<Key>) -> Self {
    Dictionary(
      uniqueKeysWithValues: keys
        .lazy
        .compactMap { key in
          guard let value = self[key] else {
            return nil
          }
          
          return (key, value)
        }
    )
  }

  @inlinable
  internal mutating func removeValues(forKeys keys: some Sequence<Key>) {
    for key in keys {
      removeValue(forKey: key)
    }
  }
  
  @inlinable
  internal mutating func inPlaceStriclyIncreasingMutation<T>(
    key: Key,
    mutation: (inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    switch index(forKey: key) {
    case .some(let index):
      try mutation(&values[index])
    case .none:
      var mutationRecipient: Set<T> = []
      try mutation(&mutationRecipient)
      assert(!mutationRecipient.isEmpty)
      if !mutationRecipient.isEmpty {
        self[key] = mutationRecipient
      }
    }
  }

  @inlinable
  internal mutating func inPlaceStriclyIncreasingMutation<T>(
    keys: Set<Key>,
    mutation: (inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    guard !keys.isEmpty else { return }
    for key in keys {
      try inPlaceStriclyIncreasingMutation(
        key: key,
        mutation: mutation
      )
    }
  }
  
  @inlinable
  internal mutating func inPlaceStriclyIncreasingMutation<T>(
    keys: some Sequence<Key>,
    mutation: (inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    for key in keys {
      try inPlaceStriclyIncreasingMutation(
        key: key,
        mutation: mutation
      )
    }
  }

  @inlinable
  internal mutating func inPlaceStriclyIncreasingMutation<T>(
    keys: some Collection<Key>,
    mutation: (inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    guard !keys.isEmpty else { return }
    for key in keys {
      try inPlaceStriclyIncreasingMutation(
        key: key,
        mutation: mutation
      )
    }
  }

  @inlinable
  internal mutating func inPlaceWeakStrictlyIncreasingMutation<T>(
    key: Key,
    mutation: (inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    guard let index = index(forKey: key) else {
      return
    }
    try mutation(&values[index])
  }
  
  @inlinable
  internal mutating func inPlaceNonDecreasingMutation<T>(
    key: Key,
    mutation: (inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    switch index(forKey: key) {
    case .some(let index):
      try mutation(&values[index])
    case .none:
      var mutationRecipient: Set<T> = []
      try mutation(&mutationRecipient)
      if !mutationRecipient.isEmpty {
        self[key] = mutationRecipient
      }
    }
  }

  @inlinable
  internal mutating func inPlaceWeakNonDecreasingMutation<T>(
    key: Key,
    mutation: (inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    guard let index = index(forKey: key) else {
      return
    }
    try mutation(&values[index])
  }
  
  @inlinable
  internal mutating func inPlaceNonIncreasingMutationWithAutomaticEmptyRemoval<T>(
    key: Key,
    mutation: (inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    guard let index = index(forKey: key) else {
      return
    }
    
    try mutation(&values[index])
    if values[index].isEmpty {
      remove(at: index)
    }
  }
  
  @inlinable
  internal mutating func inPlaceCompleteMutationWithAutomaticEmptyRemoval<T>(
    _ mutation: (Key, inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    var removedKeys: [Key] = []
    for index in indices {
      try mutation(
        keys[index],
        &values[index]
      )
      if values[index].isEmpty {
        removedKeys.append(keys[index])
      }
    }
    
    removeValues(forKeys: removedKeys)
  }

  @inlinable
  internal mutating func inPlaceCompleteMutationWithoutRemoval<T>(
    _ mutation: (Key, inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    for index in indices {
      try mutation(
        keys[index],
        &values[index]
      )
    }
  }

  @inlinable
  internal mutating func inPlaceCompleteMutation<T>(
    removeOnEmpty: Bool,
    _ mutation: (Key, inout Set<T>) throws -> Void
  ) rethrows where Value == Set<T>, T: Hashable {
    guard !isEmpty else { return }
    switch removeOnEmpty {
    case true:
      try inPlaceCompleteMutationWithAutomaticEmptyRemoval(mutation)
    case false:
      try inPlaceCompleteMutationWithoutRemoval(mutation)
    }
  }
  
}
