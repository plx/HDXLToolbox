import Foundation

extension Set {
  
  @inlinable
  internal init(
    unionOf first: some Collection<Element>,
    with other: some Collection<Element>
  ) {
    self.init(
      minimumCapacity: Swift.max(
        first.count,
        other.count
      )
    )
    
    self.formUnion(first)
    self.formUnion(other)
  }
  
  @inlinable
  internal init(
    intersectionOf first: some Collection<Element>,
    with other: some Collection<Element>
  ) {
    switch first.count <= other.count {
    case true:
      self.init(first)
      formIntersection(other)
    case false:
      self.init(other)
      formIntersection(first)
    }
  }

  @inlinable
  internal init?(
    nonEmptyIntersectionOf first: some Collection<Element>,
    with other: some Collection<Element>
  ) {
    self.init(
      intersectionOf: first,
      with: other
    )
    guard !isEmpty else { return nil }
  }
  
  @inlinable
  internal func setMap<R>(
    transformation: (Element) throws -> R
  ) rethrows -> Set<R> where R: Hashable {
    var result: Set<R> = []
    for element in self {
      result.insert(try transformation(element))
    }
    return result
  }

  @inlinable
  internal func setCompactMap<R>(
    transformation: (Element) throws -> R?
  ) rethrows -> Set<R> where R: Hashable {
    var result: Set<R> = []
    for element in self {
      guard let value = try transformation(element) else {
        continue
      }
      result.insert(value)
    }
    return result
  }

  @inlinable
  internal func nonEmptySetCompactMap<R>(
    transformation: (Element) throws -> R?
  ) rethrows -> Set<R>? where R: Hashable {
    let result = try setCompactMap(transformation: transformation)
    switch result.isEmpty {
    case true:
      return nil
    case false:
      return result
    }
  }

  @inlinable
  internal var stringLiteralRepresentation: String {
    guard !isEmpty else { return "[]" }
    
    let elements = lazy
      .map { String(describing: $0) }
      .joined(separator: ", ")
    
    return "[ \(elements) ]"
  }
  
  @inlinable
  internal var unlessEmpty: Self? {
    switch isEmpty {
    case true:
      nil
    case false:
      self
    }
  }
  
  @inlinable
  internal func nonEmptyIntersection(with other: Self) -> Self? {
    intersection(other).unlessEmpty
  }

  @inlinable
  internal func nonEmptySubtraction(of other: Self) -> Self? {
    subtracting(other).unlessEmpty
  }

  @inlinable
  internal func nonEmptySymmetricDifference(with other: Self) -> Self? {
    symmetricDifference(other).unlessEmpty
  }

  @inlinable
  internal mutating func formUnionIfPossible(_ other: Self?) {
    guard let other else { return }
    formUnion(other)
  }
}

// a bit clunky but handy:
@inlinable
internal func formNonEmptySubtraction<T>(
  of subtrahend: Set<T>,
  from minuend: inout Set<T>?
) where T: Hashable {
  minuend = minuend?.nonEmptySubtraction(of: subtrahend)
}

@inlinable
internal func formNonEmptySymmetricDifference<T>(
  of target: inout Set<T>?,
  with other: Set<T>
) where T: Hashable {
  target = target?.nonEmptySymmetricDifference(with: other)
}
