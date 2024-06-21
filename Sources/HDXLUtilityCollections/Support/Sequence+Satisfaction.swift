import Foundation
import HDXLEssentialPrecursors

extension Sequence {

  /// Returns `true` iff any element in `self` satisfies predicate.
  ///
  /// - note: I really can't see why this isn't in the stdlib.
  @inlinable
  public func anySatisfy(_ predicate: (Element) throws -> Bool ) rethrows -> Bool {
    for element in self {
      if try predicate(element) {
        return true
      }
    }
    return false
  }
  
  /// Returns the count of elements in `self` that satisfy `predicate`
  @inlinable
  public func countSatisfying(_ predicate: (Element) throws -> Bool) rethrows -> Int {
    var count: Int = 0
    for element in self {
      if try predicate(element) {
        count += 1
      }
    }
    return count
  }

  /// Returns the count of elements in `self` that fail-to-satisfy `predicate`
  @inlinable
  public func countFailing(_ predicate: (Element) throws -> Bool) rethrows -> Int {
    var count: Int = 0
    for element in self {
      if !(try predicate(element)) {
        count += 1
      }
    }
    return count
  }
  
}
