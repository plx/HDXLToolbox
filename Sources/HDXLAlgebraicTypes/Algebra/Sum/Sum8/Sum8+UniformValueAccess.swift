import Foundation
import HDXLEssentialPrecursors

extension Sum8
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
  
  typealias UniformValue = A
  typealias IdentifiedUniformValue = PositionedValue<Position, UniformValue>
  
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
    }
  }
  
  /// Like `uniformValue` but includes the arity-position from-which we sourced the value.
  @inlinable
  public var identifiedUniformValue: IdentifiedUniformValue {
    switch self {
    case .a(let v):
      IdentifiedUniformValue(.a,v)
    case .b(let v):
      IdentifiedUniformValue(.b,v)
    case .c(let v):
      IdentifiedUniformValue(.c,v)
    case .d(let v):
      IdentifiedUniformValue(.d,v)
    case .e(let v):
      IdentifiedUniformValue(.e,v)
    case .f(let v):
      IdentifiedUniformValue(.f,v)
    case .g(let v):
      IdentifiedUniformValue(.g,v)
    case .h(let v):
      IdentifiedUniformValue(.h,v)
    }
  }
  
}
