import Foundation
import HDXLEssentialPrecursors

extension Sum3
where
A == B,
A == C
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
    }
  }

}
