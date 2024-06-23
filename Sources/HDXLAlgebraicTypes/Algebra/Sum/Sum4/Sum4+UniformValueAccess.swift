import Foundation
import HDXLEssentialPrecursors

extension Sum4
where
A == B,
A == C,
A == D
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
    }
  }
  
}
