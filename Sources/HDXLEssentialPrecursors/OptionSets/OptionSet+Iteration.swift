import Foundation

extension OptionSet {
  @inlinable
  public var setAndUnset: [Self] {
    return [[], self]
  }
}
