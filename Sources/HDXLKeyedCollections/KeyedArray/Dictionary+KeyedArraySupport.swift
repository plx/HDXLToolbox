import Foundation

extension Dictionary {
  
  @inlinable
  internal mutating func inPlaceCompleteMutationWithoutRemoval<T>(
    _ mutation: (inout [T]) throws -> Void
  ) rethrows where Value == [T] {
    for index in indices {
      try mutation(&values[index])
    }
  }
  
  @inlinable
  internal mutating func inPlaceCompleteMutationWithAutomaticEmptyRemoval<T>(
    _ mutation: (Key, inout [T]) throws -> Void
  ) rethrows where Value == [T] {
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
  internal mutating func inPlaceStrictlyDecreasingMutationWithAutomaticEmptyRemoval<R,T>(
    forKey key: Key,
    _ mutation: (inout [T]) throws -> R?
  ) rethrows -> R? where Value == [T] {
    guard let index = index(forKey: key) else {
      return nil
    }
    
    let result = try mutation(&values[index])
    if values[index].isEmpty {
      remove(at: index)
    }
    
    return result
  }

}
