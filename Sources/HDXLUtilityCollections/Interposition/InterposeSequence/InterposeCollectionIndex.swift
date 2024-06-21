import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: InterposeCollectionIndex
// ------------------------------------------------------------------------- //

@frozen
public struct InterposeCollectionIndex<Index> where Index: Comparable {
  @usableFromInline
  internal typealias Position = InterposeCollectionPosition<Index>
  
  @usableFromInline
  internal typealias Interposition = InterpositionElement<Index>

  @usableFromInline
  internal var position: Position?
  
  @inlinable
  internal init(position: Position) {
    self.position = position
  }
  
  @inlinable
  internal init(index: Index) {
    self.init(position: .element(index))
  }

  @inlinable
  internal init?(possibleIndex: Index?) {
    guard let index = possibleIndex else {
      return nil
    }
    self.init(index: index)
  }

  @inlinable
  internal init(interposition: Interposition) {
    self.init(position: .interposition(interposition))
  }

  @inlinable
  internal init(__unsafePosition position: Position?) {
    self.position = position
  }
  
  @inlinable
  internal static var endIndex: InterposeCollectionIndex<Index> {
    InterposeCollectionIndex<Index>(__unsafePosition: nil)
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension InterposeCollectionIndex: Sendable where Index: Sendable { }
extension InterposeCollectionIndex: Equatable { }
extension InterposeCollectionIndex: Hashable where Index: Hashable { }
extension InterposeCollectionIndex: Encodable where Index: Encodable { }
extension InterposeCollectionIndex: Decodable where Index: Decodable { }

// ------------------------------------------------------------------------- //
// MARK: InterposeCollectionIndex - Comparable
// ------------------------------------------------------------------------- //

extension InterposeCollectionIndex: Comparable {
  @inlinable
  public static func < (
    lhs: InterposeCollectionIndex<Index>,
    rhs: InterposeCollectionIndex<Index>
  ) -> Bool {
    switch (lhs.position, rhs.position) {
    case (.none, .none):
      false
    case (.some, .none):
      true
    case (.none, .some):
      false
    case (.some(let lPosition), .some(let rPosition)):
      lPosition < rPosition
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension InterposeCollectionIndex: CustomStringConvertible {
  @inlinable
  public var description: String {
    switch position {
    case .none:
      "end-index"
    case .some(let position):
      String(describing: position)
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension InterposeCollectionIndex: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: type(of: self)))(position: \(String(reflecting: position)))"
  }
}

