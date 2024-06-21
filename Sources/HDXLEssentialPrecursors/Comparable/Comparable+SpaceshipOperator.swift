import Foundation

extension Comparable {
  @inlinable
  public static func <=> (
    lhs: Self,
    rhs: Self
  ) -> ComparisonResult {
    if lhs < rhs {
      .orderedAscending
    } else if lhs > rhs {
      .orderedDescending
    } else {
      .orderedSame
    }
  }
}
