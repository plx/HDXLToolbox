import Foundation

extension Collection where Element:SemanticEquivalenceComparable {
  
  /// `true` iff all elements in `self` have *equivalent* semantics to each other.
  @inlinable
  public var allElementsHaveEquivalentSemantics: Bool {
    guard let firstElement = first else {
      return true
    }
    
    return self[
      index(after: startIndex)..<endIndex
    ].allElementsHaveSemantics(
      equivalentTo: firstElement
    )
  }
  
  /// `true` iff all elements in `self` have *equivalent* semantics to `self`.
  @inlinable
  func allElementsHaveSemantics(
    equivalentTo element: Element
  ) -> Bool {
    allSatisfy {
      element.hasEquivalentSemantics(to: $0)
    }
  }
    
}
