import Foundation
import HDXLEssentialPrecursors

extension Int {
  @inlinable
  internal var impliedEndcapInterposeElementCount: Int {
    return 2 + impliedInterposeElementCount
  }
}
