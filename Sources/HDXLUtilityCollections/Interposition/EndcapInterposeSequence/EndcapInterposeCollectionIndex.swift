import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - Definition
// ------------------------------------------------------------------------- //

@frozen
public struct EndcapInterposeCollectionIndex<Index> where Index: Comparable {
  @usableFromInline
  internal typealias Position = EndcapInterposeCollectionPosition<Index>
  
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
  internal static var endIndex: EndcapInterposeCollectionIndex<Index> {
    EndcapInterposeCollectionIndex<Index>(__unsafePosition: nil)
  }
  
  @inlinable
  internal static var intro: EndcapInterposeCollectionIndex<Index> {
    EndcapInterposeCollectionIndex<Index>(position: .intro)
  }
  
  @inlinable
  internal static var outro: EndcapInterposeCollectionIndex<Index> {
    EndcapInterposeCollectionIndex<Index>(position: .outro)
  }
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionIndex: Sendable where Index: Sendable { }
extension EndcapInterposeCollectionIndex: Equatable { }
extension EndcapInterposeCollectionIndex: Hashable where Index: Hashable { }
extension EndcapInterposeCollectionIndex: Encodable where Index: Encodable { }
extension EndcapInterposeCollectionIndex: Decodable where Index: Decodable { }

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - Comparable
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionIndex: Comparable {
  @inlinable
  public static func < (
    lhs: EndcapInterposeCollectionIndex<Index>,
    rhs: EndcapInterposeCollectionIndex<Index>
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
// MARK: EndcapInterposeCollectionIndex - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionIndex: CustomStringConvertible {
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
// MARK: EndcapInterposeCollectionIndex - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionIndex: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: type(of: self)))(position: \(String(reflecting: position)))"
  }
}

