import Foundation
import HDXLEssentialPrecursors

extension Sum9
where
A == B,
A == C,
A == D,
A == E,
A == F,
A == G,
A == H,
A == I 
{
  
  public typealias UniformValue = A
  public typealias IdentifiedUniformValue = PositionedValue<Position, UniformValue>
  
  /// For sums of a uniform type, we can reliably extract a non-nil value of that type.
  @inlinable
  public var uniformValue: UniformValue {
    switch self {
    case .a(let v):
      v
    case .b(let v):
      v
    case .c(let v):
      v
    case .d(let v):
      v
    case .e(let v):
      v
    case .f(let v):
      v
    case .g(let v):
      v
    case .h(let v):
      v
    case .i(let v):
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
    case .c(let v):
      IdentifiedUniformValue(
        position: .c,
        value: v
      )
    case .d(let v):
      IdentifiedUniformValue(
        position: .d,
        value: v
      )
    case .e(let v):
      IdentifiedUniformValue(
        position: .e,
        value: v
      )
    case .f(let v):
      IdentifiedUniformValue(
        position: .f,
        value: v
      )
    case .g(let v):
      IdentifiedUniformValue(
        position: .g,
        value: v
      )
    case .h(let v):
      IdentifiedUniformValue(
        position: .h,
        value: v
      )
    case .i(let v):
      IdentifiedUniformValue(
        position: .i,
        value: v
      )
    }
  }
  
}
