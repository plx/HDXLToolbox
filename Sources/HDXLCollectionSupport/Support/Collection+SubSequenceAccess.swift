import Foundation
import HDXLEssentialPrecursors

extension Collection {
  
  /// Utility to grab the full-range `SubSequence` of `self`.
  @inlinable
  package var completeSubSequence: SubSequence {
    self[completeRange]
  }
  
  /// Shorthand for `self.startIndex..<self.endIndex`.
  @inlinable
  package var completeRange: Range<Index> {
    startIndex..<endIndex
  }
  
}
