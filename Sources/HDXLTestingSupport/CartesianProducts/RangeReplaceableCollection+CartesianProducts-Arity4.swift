import Foundation
import HDXLEssentialPrecursors

// MARK: - Arity-4

extension RangeReplaceableCollection {
  
  @inlinable
  public static func transformedCartesianProduct<A,B,C,D>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ dd: some Collection<D>,
    _ transformation: (A, B, C, D) throws -> Element
  ) rethrows -> Self {
    var result = Self()
    try result.appendTransformedCartesianProduct(
      aa,
      bb,
      cc,
      dd,
      transformation
    )
    
    return result
  }
  
  @inlinable
  public mutating func appendTransformedCartesianProduct<A,B,C,D>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ dd: some Collection<D>,
    _ transformation: (A, B, C, D) throws -> Element
  ) rethrows {
    guard
      allAreNonEmpty(
        aa,
        bb,
        cc,
        dd
      ) 
    else { return }
    
    reserveAdditionalCapacity(
      productOfCounts(
        aa,
        bb,
        cc,
        dd
      )
    )
    
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            append(
              try transformation(
                a,
                b,
                c,
                d
              )
            )
          }
        }
      }
    }
  }
  
}
