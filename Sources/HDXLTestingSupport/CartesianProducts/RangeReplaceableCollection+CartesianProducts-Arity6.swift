import Foundation
import HDXLEssentialPrecursors

// MARK: - Arity-6

extension RangeReplaceableCollection {
  
  @inlinable
  public static func transformedCartesianProduct<A,B,C,D,E,F>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ dd: some Collection<D>,
    _ ee: some Collection<E>,
    _ ff: some Collection<F>,
    _ transformation: (A, B, C, D, E, F) throws -> Element
  ) rethrows -> Self {
    var result = Self()
    try result.appendTransformedCartesianProduct(
      aa,
      bb,
      cc,
      dd,
      ee,
      ff,
      transformation
    )
    
    return result
  }
  
  @inlinable
  public mutating func appendTransformedCartesianProduct<A,B,C,D,E,F>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ dd: some Collection<D>,
    _ ee: some Collection<E>,
    _ ff: some Collection<F>,
    _ transformation: (A, B, C, D, E, F) throws -> Element
  ) rethrows {
    guard
      allAreNonEmpty(
        aa,
        bb,
        cc,
        dd,
        ee,
        ff
      ) 
    else { return }
    
    reserveAdditionalCapacity(
      productOfCounts(
        aa,
        bb,
        cc,
        dd,
        ee,
        ff
      )
    )
    
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            for e in ee {
              for f in ff {
                append(
                  try transformation(
                    a,
                    b,
                    c,
                    d,
                    e,
                    f
                  )
                )
              }
            }
          }
        }
      }
    }
  }
  
}
