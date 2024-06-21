import Foundation

extension Optional {
  @inlinable
  internal var oneIfPresent: Int {
    switch self {
    case .none:
      0
    case .some:
      1
    }
  }
}
