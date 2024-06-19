import Foundation

extension Set {
  
  @inlinable
  public mutating func formUnion(possibleElements: (some Sequence<Element>)?) {
    switch possibleElements {
    case .none:
      ();
    case .some(let elements):
      formUnion(elements)
    }
  }
  
  @inlinable
  public func union(possibleElements: (some Sequence<Element>)?) -> Set<Element> {
    switch possibleElements {
    case .none:
      return self
    case .some(let elements):
      return union(elements)
    }
  }
  
  @inlinable
  public mutating func formIntersection(
    possibleElements: (some Sequence<Element>)?,
    interpretingNilAs nilInterpretation: SetAlgebraNilInterpretation = .nothing
  ) {
    switch (possibleElements, nilInterpretation) {
    case (.none, .nothing):
      ();
    case (.none, .emptySet):
      removeAll()
    case (.some(let elements), _):
      formIntersection(elements)
    }
  }
  
  @inlinable
  public func intersection(
    possibleElements: (some Sequence<Element>)?,
    interpretingNilAs nilInterpretation: SetAlgebraNilInterpretation = .nothing
  ) -> Set<Element> {
    switch (possibleElements, nilInterpretation) {
    case (.none, .nothing):
      return self
    case (.none, .emptySet):
      return []
    case (.some(let elements), _):
      return intersection(elements)
    }
  }

  @inlinable
  public mutating func formSymmetricDifference(possibleElements: (some Sequence<Element>)?) {
    switch possibleElements {
    case .none:
      ();
    case .some(let elements):
      formSymmetricDifference(elements)
    }
  }

  @inlinable
  public func symmetricDifference(possibleElements: (some Sequence<Element>)?) -> Set<Element> {
    switch possibleElements {
    case .none:
      return self
    case .some(let elements):
      return symmetricDifference(elements)
    }
  }

  @inlinable
  public mutating func subtract(possibleElements: (some Sequence<Element>)?) {
    switch possibleElements {
    case .none:
      ();
    case .some(let elements):
      subtract(elements)
    }
  }
  
  @inlinable
  public func subtracting(possibleElements: (some Sequence<Element>)?) -> Set<Element> {
    switch possibleElements {
    case .none:
      return self
    case .some(let elements):
      return subtracting(elements)
    }
  }

}
