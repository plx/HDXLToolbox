import Foundation
import HDXLEssentialPrecursors

@usableFromInline
internal enum AffixSequenceIterationState {
  case prefix
  case base
  case suffix
  case exhausted
}
