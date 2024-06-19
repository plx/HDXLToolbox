import Foundation

extension RangeReplaceableCollection {
  
  @inlinable
  public mutating func reserveAdditionalCapacity(_ additionalCapacity: Int) {
    guard additionalCapacity > 0 else { return }
    reserveCapacity(count + additionalCapacity)
  }
  
}
