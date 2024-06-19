import Foundation

extension Collection {
  
  @inlinable
  package var startPosition: PositionIndexStorage<Index> {
    switch isEmpty {
    case true:
      .endIndex
    case false:
      .position(startIndex)
    }
  }
  
  @inlinable
  package func index(forPositionIndexStorage positionIndexStorage: PositionIndexStorage<Index>) -> Index {
    switch positionIndexStorage {
    case .position(let index):
      index
    case .endIndex:
      endIndex
    }
  }
  
  @inlinable
  package func subscriptableIndex(forPositionIndexStorage positionIndexStorage: PositionIndexStorage<Index>) -> Index? {
    switch positionIndexStorage {
    case .position(let index):
      assert(index != endIndex)
      return index
    case .endIndex:
      return nil
    }
  }
  
  @inlinable
  package func positionIndexStorage(forIndex index: Index) -> PositionIndexStorage<Index> {
    switch index == endIndex {
    case true:
      .endIndex
    case false:
      .position(index)
    }
  }
  
}
