import Foundation

extension SetAlgebra {
  
  @inlinable
  public func contains(possibleElement: Element?) -> Bool {
    switch possibleElement {
    case .none:
      return false
    case .some(let element):
      return contains(element)
    }
  }
  
  @inlinable
  @discardableResult
  public mutating func insert(possibleElement: Element?) -> (inserted: Bool, possibleMemberAfterInsert: Element?) {
    switch possibleElement {
    case .none:
      return (
        inserted: false,
        possibleMemberAfterInsert: nil
      )
    case .some(let element):
      let result = insert(element)
      return (
        inserted: result.inserted,
        possibleMemberAfterInsert: result.memberAfterInsert
      )
    }
  }
  
  @inlinable
  @discardableResult
  public mutating func remove(possibleElement: Element?) -> Element? {
    switch possibleElement {
    case .none:
      return nil
    case .some(let element):
      return remove(element)
    }
  }
  
  @inlinable
  public mutating func formUnion(possibleElements: Self?) {
    switch possibleElements {
    case .none:
      ();
    case .some(let elements):
      formUnion(elements)
    }
  }
  
  @inlinable
  public func union(possibleElements: Self?) -> Self {
    switch possibleElements {
    case .none:
      return self
    case .some(let elements):
      return union(elements)
    }
  }
  
  @inlinable
  public mutating func formIntersection(
    possibleElements: Self?,
    interpretingNilAs nilInterpretation: SetAlgebraNilInterpretation = .nothing
  ) {
    switch (possibleElements, nilInterpretation) {
    case (.none, .nothing):
      ();
    case (.none, .emptySet):
      self = Self()
    case (.some(let elements), _):
      formIntersection(elements)
    }
  }
  
  @inlinable
  public func intersection(
    possibleElements: Self?,
    interpretingNilAs nilInterpretation: SetAlgebraNilInterpretation = .nothing
  ) -> Self {
    switch (possibleElements, nilInterpretation) {
    case (.none, .nothing):
      return self
    case (.none, .emptySet):
      return Self()
    case (.some(let elements), _):
      return intersection(elements)
    }
  }
  
  @inlinable
  public mutating func formSymmetricDifference(possibleElements: Self?) {
    switch possibleElements {
    case .none:
      ();
    case .some(let elements):
      formSymmetricDifference(elements)
    }
  }
  
  @inlinable
  public func symmetricDifference(possibleElements: Self?) -> Self {
    guard let elements = possibleElements else {
      return self
    }
    return symmetricDifference(elements)
  }
  
  @inlinable
  public mutating func subtract(possibleElements: Self?) {
    switch possibleElements {
    case .none:
      ();
    case .some(let elements):
      subtract(elements)
    }
  }
  
  @inlinable
  public mutating func subtracting(possibleElements: Self?) -> Self {
    switch possibleElements {
    case .none:
      return self
    case .some(let elements):
      return subtracting(elements)
    }
  }
  
}
