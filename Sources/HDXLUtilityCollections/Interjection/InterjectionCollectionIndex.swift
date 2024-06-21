import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: InterjectionCollectionIndex - Definition
// ------------------------------------------------------------------------- //

@frozen
public struct InterjectionCollectionIndex<Base> where Base: Comparable {
  @usableFromInline
  internal typealias Position = InterjectionCollectionPosition<Base>
  
  @usableFromInline
  internal typealias Interjection = InterpositionElement<Base>

  @usableFromInline
  internal var position: Position?
  
  @inlinable
  internal init(position: Position) {
    self.position = position
  }
  
  @inlinable
  internal init(index: Base) {
    self.init(position: .element(index))
  }

  @inlinable
  internal init?(possibleIndex: Base?) {
    guard let index = possibleIndex else {
      return nil
    }
    self.init(index: index)
  }

  @inlinable
  internal init(interjection: Interjection) {
    self.init(position: .interjection(interjection))
  }

  @inlinable
  internal init(__unsafePosition position: Position?) {
    self.position = position
  }
  
  @inlinable
  internal static var endIndex: InterjectionCollectionIndex<Base> {
    return InterjectionCollectionIndex<Base>(__unsafePosition: nil)
  }
}

// ------------------------------------------------------------------------- //
// MARK: InterjectionCollectionIndex - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension InterjectionCollectionIndex: Sendable where Base: Sendable { }
extension InterjectionCollectionIndex: Equatable { }
extension InterjectionCollectionIndex: Hashable where Base: Hashable { }
extension InterjectionCollectionIndex: Codable where Base: Codable { }

// ------------------------------------------------------------------------- //
// MARK: InterjectionCollectionIndex - Comparable
// ------------------------------------------------------------------------- //

extension InterjectionCollectionIndex: Comparable {
  @inlinable
  public static func < (
    lhs: InterjectionCollectionIndex<Base>,
    rhs: InterjectionCollectionIndex<Base>
  ) -> Bool {
    switch (lhs.position, rhs.position) {
    case (.none, .none):
      return false
    case (.some, .none):
      return true
    case (.none, .some):
      return false
    case (.some(let lPosition), .some(let rPosition)):
      return lPosition < rPosition
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: InterjectionCollectionIndex - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension InterjectionCollectionIndex: CustomStringConvertible {
  @inlinable
  public var description: String {
    switch position {
    case .none:
      return "end-index"
    case .some(let position):
      return String(describing: position)
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: InterjectionCollectionIndex - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension InterjectionCollectionIndex: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    return "\(String(reflecting: type(of: self)))(position: \(String(reflecting: position)))"
  }
}

