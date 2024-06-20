import Foundation

extension Sequence {
  
  @inlinable
  public func onDemandCompactMap<R>(_ transformation: @escaping @Sendable (Element) -> R?) -> OnDemandCompactMapSequence<R, Self> {
    OnDemandCompactMapSequence(base: self, transformation: transformation)
  }
  
}

@frozen
public struct OnDemandCompactMapSequence<Element, Base> where Base: Sequence {
  
  public let base: Base
  
  @usableFromInline
  internal let transformation: @Sendable (Base.Element) -> Element?
    
  @inlinable
  internal init(
    base: Base,
    transformation: @escaping @Sendable (Base.Element) -> Element?
  ) {
    self.base = base
    self.transformation = transformation
  }
  
}

extension OnDemandCompactMapSequence: Sendable where Base: Sendable {}

extension OnDemandCompactMapSequence: Sequence {
  
  public typealias Iterator = OnDemandCompactMapSequenceIterator<Element, Base.Iterator>
  
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
public struct OnDemandCompactMapSequenceIterator<Element, Base>: IteratorProtocol where Base:IteratorProtocol {
  @usableFromInline
  internal var base: Base
  
  @usableFromInline
  internal let transformation: @Sendable (Base.Element) -> Element?
  
  @inlinable
  internal init(
    base: Base,
    transformation: @escaping @Sendable (Base.Element) -> Element?
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
