import Foundation
import HDXLEssentialPrecursors

// MARK: - Arity-3

extension RangeReplaceableCollection {
  
  @inlinable
  public static func transformedCartesianProduct<A,B,C>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ transformation: (A, B, C) throws -> Element
  ) rethrows -> Self {
    var result = Self()
    try result.appendTransformedCartesianProduct(
      aa,
      bb,
      cc,
      transformation
    )
    
    return result
  }
  
  @inlinable
  public mutating func appendTransformedCartesianProduct<A,B,C>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ transformation: (A, B, C) throws -> Element
  ) rethrows {
    guard
      allAreNonEmpty(
        aa,
        bb,
        cc
      ) 
    else { return }
    
    reserveAdditionalCapacity(
      productOfCounts(
        aa,
        bb,
        cc
      )
    )
    
    for a in aa {
      for b in bb {
        for c in cc {
          append(
            try transformation(
              a,
              b,
              c
            )
          )
        }
      }
    }
  }
  
}
