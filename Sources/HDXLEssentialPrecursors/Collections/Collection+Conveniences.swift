
extension Collection {
  
  @inlinable
  package var unlessEmpty: Self? {
    switch isEmpty {
    case true:
      nil
    case false:
      self
    }
  }
  
}
