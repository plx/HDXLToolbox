import Foundation
import HDXLEssentialPrecursors

public extension Sum8 
where
A:Comparable,
B:Comparable,
C:Comparable,
D:Comparable,
E:Comparable,
F:Comparable,
G:Comparable,
H:Comparable
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
    case (.g(let l), .g(let r)):
      l <=> r
    case (.h(let l), .h(let r)):
      l <=> r
    default:
      occupiedPosition <=> other.occupiedPosition
    }
  }

}


