import Foundation
import HDXLEssentialPrecursors

extension Collection {
  
  @inlinable
  package func reduced(
    to index: Index
  ) -> CollectionOfOne<Element> {
    CollectionOfOne<Element>(self[index])
  }
  
}
