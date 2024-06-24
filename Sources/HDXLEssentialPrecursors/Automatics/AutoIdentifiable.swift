import Foundation

package protocol AutoIdentifiable where Self: Hashable, Self: Identifiable, ID == Self { }

extension AutoIdentifiable {
  @inlinable
  public var id: ID { self }
}
