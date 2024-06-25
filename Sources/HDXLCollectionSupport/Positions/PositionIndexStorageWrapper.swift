import HDXLEssentialPrecursors

@usableFromInline
package protocol PositionIndexStorageWrapper<Position> : Comparable {
  associatedtype Position: Comparable
  
  var storage: PositionIndexStorage<Position> { get set }
  
  init(storage: PositionIndexStorage<Position>)
  
}

extension PositionIndexStorageWrapper {
  
  @inlinable
  public static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.storage < rhs.storage
  }
  
  @inlinable
  package static var endIndex: Self {
    Self(storage: .endIndex)
  }

  @inlinable
  package static func position(_ position: Position) -> Self {
    Self(position: position)
  }

  @inlinable
  package init(position: Position) {
    self.init(storage: .position(position))
  }
  
  @inlinable
  package init?(possiblePosition: Position?) {
    guard let position = possiblePosition else {
      return nil
    }
    self.init(position: position)
  }
  
}
