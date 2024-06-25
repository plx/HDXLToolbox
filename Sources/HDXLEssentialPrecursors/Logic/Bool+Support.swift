
extension Bool {
  
  @inlinable
  package var oneIfTrue: Int {
    switch self {
    case true:
      1
    case false:
      0
    }
  }
  
}
