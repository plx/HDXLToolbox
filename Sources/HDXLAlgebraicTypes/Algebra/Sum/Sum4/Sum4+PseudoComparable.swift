import Foundation
import HDXLEssentialPrecursors

public extension Sum4
where
A:Comparable,
B:Comparable,
C:Comparable,
D:Comparable
{
  
  @inlinable
  package func lexicographicOrderingRelationship(with other: Self) -> Bool {
    switch (self, other) {
    case (.a(let l), .a(let r)):
      l <=> r
    case (.b(let l), .b(let r)):
      l <=> r
    case (.c(let l), .c(let r)):
      l <=> r
    case (.d(let l), .d(let r)):
      l <=> r
    default:
      occupiedPosition <=> other.occupiedPosition
    }
  }

}


