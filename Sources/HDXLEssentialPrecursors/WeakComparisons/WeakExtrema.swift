

/// Provides the minimum observed non-nil value (if any).
@inlinable
package func possibleMinimum<T>(
  _ possibleValues: T?...
) -> T? where T: Comparable {
  var result: T? = nil
  for possibleValue in possibleValues {
    switch (result, possibleValue) {
    case (.none, .none):
      continue
    case (.none, .some(let value)):
      result = value
    case (.some(let previousMinimum), .some(let value)):
      result = Swift.min(previousMinimum, value)
    case (.some(let previousMinimum), .none):
      result = previousMinimum
    }
  }
  
  return result
}

/// Provides the maximum observed non-nil value (if any).
@inlinable
package func possibleMaximum<T>(
  _ possibleValues: T?...
) -> T? where T: Comparable {
  var result: T? = nil
  for possibleValue in possibleValues {
    switch (result, possibleValue) {
    case (.none, .none):
      continue
    case (.none, .some(let value)):
      result = value
    case (.some(let previousMaximum), .some(let value)):
      result = Swift.max(previousMaximum, value)
    case (.some(let previousMaximum), .none):
      result = previousMaximum
    }
  }
  
  return result
}
