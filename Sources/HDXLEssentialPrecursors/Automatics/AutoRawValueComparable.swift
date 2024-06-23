import Foundation

public protocol AutoRawValueComparable: RawRepresentable, Comparable where RawValue: Comparable { }

extension AutoRawValueComparable {
  
  @inlinable
  public static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
