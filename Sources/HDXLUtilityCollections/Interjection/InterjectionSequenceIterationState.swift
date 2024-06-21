import Foundation
import HDXLEssentialPrecursors

@usableFromInline
internal enum InterjectionSequenceIterationState<Base> {
  case initial
  case element
  case interjection(Base)
  case exhausted
}
