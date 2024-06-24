import Foundation

@usableFromInline
package protocol CloneableObject : AnyObject {
  
  func obtainClone() -> Self
  
}

extension CloneableObject {
  
  @inlinable
  package func obtainModifiedClone(
    _ mutator: (inout Self) throws -> Void
  ) rethrows -> Self {
    var clone = obtainClone()
    try mutator(&clone)
    return clone
  }
  
}
