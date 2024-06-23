import Foundation
import HDXLEssentialPrecursors

extension Sum2 where A == B {
  
  public typealias UniformValue = A
  public typealias IdentifiedUniformValue = PositionedValue<Position,UniformValue>
  
  /// For sums of a uniform type, we can reliably extract a non-nil value of that type.
  @inlinable
  public var uniformValue: UniformValue {
    switch self {
    case .a(let v):
      v
    case .b(let v):
      v
    }
  }
  
  /// Like `uniformValue` but includes the arity-position from-which we sourced the value.
  @inlinable
  public var identifiedUniformValue: IdentifiedUniformValue {
    switch self {
    case .a(let v):
      IdentifiedUniformValue(
        position: .a,
        value: v
      )
    case .b(let v):
      IdentifiedUniformValue(
        position: .b,
        value: v
      )
    }
  }

}