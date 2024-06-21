import Foundation
import HDXLEssentialPrecursors

internal extension Collection {
  
  @inlinable
  func reduced(to index: Index) -> CollectionOfOne<Element> {
    precondition(index < endIndex)
    
    return CollectionOfOne<Element>(self[index])
  }
  
}
