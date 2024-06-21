import Foundation

extension Set {
  
  @inlinable
  public init(bulkUnionOf collections: some Collection<some Collection<Element>>) {
    self.init()
    
    let totalElementCount = collections.reduce(0) { $0 + $1.count }
    guard totalElementCount > 0 else {
      return
    }
    
    reserveCapacity(totalElementCount)
    for collection in collections where !collection.isEmpty {
      formUnion(collection)
    }
  }

  @inlinable
  public init(bulkUnionOf sets: some Collection<Set<Element>>) {
    self.init()
    
    let totalElementCount = sets.reduce(0) { $0 + $1.count }
    guard totalElementCount > 0 else {
      return
    }
    
    reserveCapacity(totalElementCount)
    for set in sets where !set.isEmpty {
      formUnion(set)
    }
  }

}
