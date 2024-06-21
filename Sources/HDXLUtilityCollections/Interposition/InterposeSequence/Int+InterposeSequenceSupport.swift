import Foundation
import HDXLEssentialPrecursors

extension Int {
  @inlinable
  internal var impliedInterposeElementCount: Int {
    let elementCount = Swift.max(0, self)
    let interpositionCount = Swift.max(0, self - 1)
    return elementCount + interpositionCount
  }
}
