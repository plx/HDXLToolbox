import Foundation

@inlinable
package func smallerThenLarger<T>(
  _ first: T,
  _ other: T
) -> (T, T) where T: Collection {
  switch first.count <= other.count {
  case true:
    (first, other)
  case false:
    (other, first)
  }
}
