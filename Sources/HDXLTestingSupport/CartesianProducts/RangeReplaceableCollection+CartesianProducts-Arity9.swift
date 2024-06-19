import Foundation
import HDXLEssentialPrecursors

// MARK: - Arity-9

extension RangeReplaceableCollection {
  
  @inlinable
  public static func transformedCartesianProduct<A,B,C,D,E,F,G,H,I>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ dd: some Collection<D>,
    _ ee: some Collection<E>,
    _ ff: some Collection<F>,
    _ gg: some Collection<G>,
    _ hh: some Collection<H>,
    _ ii: some Collection<I>,
    _ transformation: (A, B, C, D, E, F, G, H, I) throws -> Element
  ) rethrows -> Self {
    var result = Self()
    try result.appendTransformedCartesianProduct(
      aa,
      bb,
      cc,
      dd,
      ee,
      ff,
      gg,
      hh,
      ii,
      transformation
    )
    
    return result
  }
  
  @inlinable
  public mutating func appendTransformedCartesianProduct<A,B,C,D,E,F,G,H,I>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ cc: some Collection<C>,
    _ dd: some Collection<D>,
    _ ee: some Collection<E>,
    _ ff: some Collection<F>,
    _ gg: some Collection<G>,
    _ hh: some Collection<H>,
    _ ii: some Collection<I>,
    _ transformation: (A, B, C, D, E, F, G, H, I) throws -> Element
  ) rethrows {
    guard
      allAreNonEmpty(
        aa,
        bb,
        cc,
        dd,
        ee,
        ff,
        gg,
        hh,
        ii
      ) 
    else { return }
    
    reserveAdditionalCapacity(
      productOfCounts(
        aa,
        bb,
        cc,
        dd,
        ee,
        ff,
        gg,
        hh,
        ii
      )
    )
    
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            for e in ee {
              for f in ff {
                for g in gg {
                  for h in hh {
                    for i in ii {
                      append(
                        try transformation(
                          a,
                          b,
                          c,
                          d,
                          e,
                          f,
                          g,
                          h,
                          i
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
    }
  }
  
}
