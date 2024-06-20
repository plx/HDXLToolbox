import Foundation
import HDXLEssentialPrecursors

// MARK: - Arity-5

extension RangeReplaceableCollection {
  
  @inlinable
  public static func transformedCartesianProduct<A,B,C,D,E>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ dd: some Collection<D>,
    _ ee: some Collection<E>,
    _ transformation: (A, B, C, D, E) throws -> Element
  ) rethrows -> Self {
    var result = Self()
    try result.appendTransformedCartesianProduct(
      aa,
      bb,
      cc,
      dd,
      ee,
      transformation
    )
    
    return result
  }
  
  @inlinable
  public mutating func appendTransformedCartesianProduct<A,B,C,D,E>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ dd: some Collection<D>,
    _ ee: some Collection<E>,
    _ transformation: (A, B, C, D, E) throws -> Element
  ) rethrows {
    guard
      allAreNonEmpty(
        aa,
        bb,
        cc,
        dd,
        ee
      ) 
    else { return }
    
    reserveAdditionalCapacity(
      productOfCounts(
        aa,
        bb,
        cc,
        dd,
        ee
      )
    )
    
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            for e in ee {
              append(
                try transformation(
                  a,
                  b,
                  c,
                  d,
                  e
                )
              )
            }
          }
        }
      }
    }
  }
  
}
