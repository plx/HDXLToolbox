import Foundation
import SwiftUI

// MARK: - AdditiveArithmetic

@inlinable
package func zeroTuple<each T: AdditiveArithmetic>(
  for values: (repeat (each T).Type)
) -> (repeat each T) {
  return (repeat (each values).zero)
}

@inlinable
package func outOfPlaceAdditionTuple<each T: AdditiveArithmetic>(
  lhs: (repeat each T),
  rhs: (repeat each T)
) -> (repeat each T) {
  return (repeat (each lhs + each rhs))
}

@inlinable
package func outOfPlaceSubtractionTuple<each T: AdditiveArithmetic>(
  lhs: repeat each T,
  rhs: repeat each T
) -> (repeat each T) {
  return (repeat (each lhs - each rhs))
}

//// MARK: - VectorArithmetic
//
//@inlinable
//package func scaledByFactorTuple<each T: VectorArithmetic>(
//  for values: (repeat each T),
//  scaledBy factor: Double
//) -> (repeat each T) {
//  return (repeat mutation(of: each values) { $0.scale(by: factor)} )
//}
//
@inlinable
package func magnitudeSquared<each T: VectorArithmetic>(
  for values: (repeat each T)
) -> Double {
  var result: Double = 0.0
  for value in repeat each values {
    result += value.magnitudeSquared
  }
  
  return result
}
