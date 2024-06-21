import Foundation
import HDXLEssentialPrecursors

extension AsyncSequence {
  @inlinable
  public func withInterjection(_ interjection: Element) -> AsyncInterjectionSequence<Self> {
    AsyncInterjectionSequence<Self>(
      interjection: interjection,
      base: self
    )
  }
}

@frozen
public struct AsyncInterjectionSequence<Base>: AsyncSequence where Base: AsyncSequence {
  public typealias Element = Base.Element
  public typealias AsyncIterator = AsyncInterjectionSequenceIterator<Base.AsyncIterator>
  
  @usableFromInline
  internal let interjection: Element
  
  @usableFromInline
  internal let base: Base
  
  @inlinable
  internal init(
    interjection: Element,
    base: Base
  ) {
    self.interjection = interjection
    self.base = base
  }
  
  @inlinable
  public func makeAsyncIterator() -> AsyncIterator {
    return AsyncIterator(
      interjection: interjection,
      base: base.makeAsyncIterator()
    )
  }
}

extension AsyncInterjectionSequence: Sendable where Base: Sendable, Base.Element: Sendable {}
extension AsyncInterjectionSequence: Equatable where Base: Equatable, Base.Element: Equatable {}
extension AsyncInterjectionSequence: Hashable where Base: Hashable, Base.Element: Hashable {}
extension AsyncInterjectionSequence: Codable where Base: Codable, Base.Element: Codable {}

extension AsyncInterjectionSequence: CustomStringConvertible {
  @inlinable
  public var description: String {
    return "interjection-of \(String(describing: interjection)) within \(String(describing: base))"
  }
}

extension AsyncInterjectionSequence: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    return "\(String(reflecting: type(of: self)))(interjection: \(String(reflecting: interjection)), base: \(String(reflecting: base)))"
  }
}
