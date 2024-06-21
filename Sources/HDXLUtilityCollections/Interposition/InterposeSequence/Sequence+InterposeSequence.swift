import Foundation
import HDXLEssentialPrecursors

extension Sequence {
  @inlinable
  public var interpositions: InterposeSequence<Self> {
    InterposeSequence<Self>(base: self)
  }
}
