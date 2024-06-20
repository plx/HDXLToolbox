import Foundation
import HDXLEssentialPrecursors

@inlinable
package func productOfCounts<each T: Collection>(
  _ collections: repeat each T
) -> Int {
  var count: Int = 1
  for collection in repeat each collections {
    count *= collection.count
  }
  
  return count
}

@inlinable
package func allAreNonEmpty<each T: Collection>(
  _ collections: repeat each T
) -> Bool {
  for collection in repeat each collections {
    if collection.isEmpty {
      return false
    }
  }
  
  return true
}

@inlinable
package func anyAreEmpty<each T: Collection>(
  _ collections: (repeat each T)
) -> Bool {
  for collection in repeat each collections {
    if collection.isEmpty {
      return true
    }
  }
  
  return false
}
