import Foundation

extension Sequence {
  
  @inlinable
  public func localOnDemandCompactMap<R>(_ transformation: @escaping (Element) -> R?) -> LocalOnDemandCompactMapSequence<R, Self> {
    LocalOnDemandCompactMapSequence(base: self, transformation: transformation)
  }
  
}

@frozen
public struct LocalOnDemandCompactMapSequence<Element, Base> where Base: Sequence {
  
  public let base: Base
  
  @usableFromInline
  internal let transformation: (Base.Element) -> Element?
    
  @inlinable
  internal init(
    base: Base,
    transformation: @escaping (Base.Element) -> Element?
  ) {
    self.base = base
    self.transformation = transformation
  }
  
}

extension LocalOnDemandCompactMapSequence: Sequence {
  
  public typealias Iterator = LocalOnDemandCompactMapSequenceIterator<Element, Base.Iterator>
  
  @inlinable
  public var underestimatedCount: Int {
    0 // sad but true
  }
  
  @inlinable
  public func makeIterator() -> Iterator {
    Iterator(
      base: base.makeIterator(),
      transformation: transformation
    )
  }
  
}

@frozen
public struct LocalOnDemandCompactMapSequenceIterator<Element, Base>: IteratorProtocol where Base:IteratorProtocol {
  @usableFromInline
  internal var base: Base
  
  @usableFromInline
  internal let transformation: (Base.Element) -> Element?
  
  @inlinable
  internal init(
    base: Base,
    transformation: @escaping (Base.Element) -> Element?
  ) {
    self.base = base
    self.transformation = transformation
  }

  @inlinable
  public mutating func next() -> Element? {
    while case .some(let nextBaseElement) = base.next() {
      switch transformation(nextBaseElement) {
      case .some(let nonNilResult):
        return nonNilResult
      case .none:
        continue
      }
    }
    
    return nil
  }

}
