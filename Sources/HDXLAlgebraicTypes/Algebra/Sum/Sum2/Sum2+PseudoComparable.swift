import Foundation
import HDXLEssentialPrecursors

extension Sum2 where A:Comparable, B:Comparable {
  
  @inlinable
  package func lexicographicOrderingRelationship(with other: Self) -> Bool {
    switch (self, other) {
    case (.a(let l), .a(let r)):
      l <=> r
    case (.b(let l), .b(let r)):
      l <=> r
    default:
      occupiedPosition <=> other.occupiedPosition
    }
  }

}

