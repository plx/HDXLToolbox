import Foundation
import HDXLEssentialPrecursors

// MARK: - Arity-2

extension RangeReplaceableCollection {
  
  @inlinable
  public static func transformedCartesianProduct<A,B>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ transformation: (A, B) throws -> Element
  ) rethrows -> Self {
    var result = Self()
    try result.appendTransformedCartesianProduct(
      aa,
      bb,
      transformation
    )
    
    return result
  }
  
  @inlinable
  public mutating func appendTransformedCartesianProduct<A,B>(
    _ aa: some Collection<A>,
    _ bb: some Collection<B>,
    _ transformation: (A, B) throws -> Element
  ) rethrows {
    guard
      allAreNonEmpty(
        aa,
        bb
      ) 
    else { return }
    
    reserveAdditionalCapacity(
      productOfCounts(
        aa,
        bb
      )
    )
    
    for a in aa {
      for b in bb {
        append(
          try transformation(
            a,
            b
          )
        )
      }
    }
  }
  
}
