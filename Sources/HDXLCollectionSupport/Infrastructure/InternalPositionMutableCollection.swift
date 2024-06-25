import HDXLEssentialPrecursors

@usableFromInline
package protocol InternalPositionMutableCollection: InternalPositionCollection, MutableCollection {
  
  subscript(position: InternalPosition) -> Element { get set }
}

extension InternalPositionMutableCollection {
  
  @inlinable
  public subscript(index: Index) -> Element {
    get {
      guard case .position(let position) = index.storage else {
        preconditionFailure(
          """
          Attempted to subscript the `endIndex` on \(String(reflecting: self))!
          """
        )
      }
      
      return self[position]
    }
    set {
      guard case .position(let position) = index.storage else {
        preconditionFailure(
          """
          Attempted to subscript the `endIndex` on \(String(reflecting: self))!
          """
        )
      }
      
      self[position] = newValue
    }
  }
  
}
