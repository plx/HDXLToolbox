
@inlinable
package func anyAreEmpty<each T: Collection>(
  _ collections: repeat each T
) -> Bool {
  for collection in repeat each collections {
    if collection.isEmpty {
      return true
    }
  }
  
  return false
}

@inlinable
package func anyAreEmpty<each T: Collection>(
  in collections: (repeat each T)
) -> Bool {
  for collection in repeat each collections {
    if collection.isEmpty {
      return true
    }
  }
  
  return false
}

@inlinable
package func allAreEmpty<each T: Collection>(
  _ collections: repeat each T
) -> Bool {
  for collection in repeat each collections {
    if !collection.isEmpty {
      return false
    }
  }
  
  return true
}

@inlinable
package func allAreEmpty<each T: Collection>(
  in collections: (repeat each T)
) -> Bool {
  for collection in repeat each collections {
    if !collection.isEmpty {
      return false
    }
  }
  
  return true
}

@inlinable
package func totalCount<each T: Collection>(
  _ collections: repeat each T
) -> Int {
  var result: Int = 0
  for collection in repeat each collections {
    result += collection.count
  }
  
  return result
}

@inlinable
package func totalCount<each T: Collection>(
  in collections: (repeat each T)
) -> Int {
  var result: Int = 0
  for collection in repeat each collections {
    result += collection.count
  }
  
  return result
}
