
package protocol LinearizableCollection : Collection {
  
  func linearIndex(forIndex index: Index) -> Int
  func index(forLinearIndex linearIndex: Int) -> Index
  
}

extension LinearizableCollection {
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index
  ) -> Int {
    linearIndex(forIndex: end) - linearIndex(forIndex: start)
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    precondition(
      i < endIndex,
      """
      Attempted to advance the `endIndex` on `\(String(reflecting: self))`!
      """
    )
    
    return index(
      forLinearIndex: 1 + linearIndex(forIndex: i)
    )
  }
  
}
