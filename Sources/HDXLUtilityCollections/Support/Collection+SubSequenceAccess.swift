import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

extension Collection {
  
  /// Utility to grab the full-range `SubSequence` of `self`.
  @inlinable
  internal var completeSubSequence: SubSequence {
    self[completeRange]
  }
  
  /// Shorthand for `self.startIndex..<self.endIndex`.
  @inlinable
  internal var completeRange: Range<Index> {
    startIndex..<endIndex
  }
  
}
