import Foundation
import HDXLEssentialPrecursors

@usableFromInline
internal enum AdacentPairIterationState<Element> {
  case initial
  case iterating(Element)
  case exhausted
}

