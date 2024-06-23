import Foundation
import HDXLEssentialPrecursors

public extension Sum5
where
A:Comparable,
B:Comparable,
C:Comparable,
D:Comparable,
E:Comparable
{
  
  @inlinable
  package func lexicographicOrderingRelationship(with other: Self) -> ComparisonResult {
    switch (self, other) {
    case (.a(let l), .a(let r)):
      l <=> r
    case (.b(let l), .b(let r)):
      l <=> r
    case (.c(let l), .c(let r)):
      l <=> r
    case (.d(let l), .d(let r)):
      l <=> r
    case (.e(let l), .e(let r)):
      l <=> r
    default:
      occupiedPosition <=> other.occupiedPosition
    }
  }

}

extension Sum5: Comparable
where
A:Comparable,
B:Comparable,
C:Comparable,
D:Comparable,
E:Comparable
{
  @inlinable
  public static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.lexicographicOrderingRelationship(with: rhs).impliesLessThan
  }
  
}
