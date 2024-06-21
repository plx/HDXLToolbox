import Foundation

extension KeyedSet {
  
  @inlinable
  public func partitionedByKeys(
    by keyPredicate: (Key) throws -> Bool
  ) rethrows -> (passing: Self, failing: Self) {
    var passing = Self()
    var failing = Self()
    for (key, valueSet) in storage {
      switch try keyPredicate(key) {
      case true:
        passing[key] = valueSet
      case false:
        failing[key] = valueSet
      }
    }
    
    return (
      passing: passing,
      failing: failing
    )
  }

  @inlinable
  public func partitionedByValues(
    by valuePredicate: (Value) throws -> Bool
  ) rethrows -> (passing: Self, failing: Self) {
    var passing = Self()
    var failing = Self()
    for (key, valueSet) in storage {
      for value in valueSet {
        switch try valuePredicate(value) {
        case true:
          passing.insert(
            value: value,
            forKey: key
          )
        case false:
          failing.insert(
            value: value,
            forKey: key
          )
        }
      }
    }
    
    return (
      passing: passing,
      failing: failing
    )
  }

  @inlinable
  public func partitionedByPairs(
    by pairPredicate: (Key, Value) throws -> Bool
  ) rethrows -> (passing: Self, failing: Self) {
    var passing = Self()
    var failing = Self()
    for (key, valueSet) in storage {
      for value in valueSet {
        switch try pairPredicate(key, value) {
        case true:
          passing.storage[
            key,
            default: []
          ].insert(value)
        case false:
          failing.storage[
            key,
            default: []
          ].insert(value)
        }
      }
    }
    
    return (
      passing: passing,
      failing: failing
    )
  }

}
