import Foundation
import HDXLEssentialPrecursors

public extension Sum6
where
A:Comparable,
B:Comparable,
C:Comparable,
D:Comparable,
E:Comparable,
F:Comparable
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
    case (.f(let l), .f(let r)):
      l <=> r
    default:
      occupiedPosition <=> other.occupiedPosition
    }
  }

}

extension Sum6: Comparable
where
A:Comparable,
B:Comparable,
C:Comparable,
D:Comparable,
E:Comparable,
F:Comparable
{
  @inlinable
  public static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.lexicographicOrderingRelationship(with: rhs).impliesLessThan
  }
  
}
