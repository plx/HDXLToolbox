import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - Definition
// ------------------------------------------------------------------------- //

@frozen
@ConditionallySendable
@AlwaysEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyAutoIdentifiable
public struct EndcapInterposeCollectionIndex<Base>: PositionIndexStorageWrapper where Base: Comparable {
  @usableFromInline
  package typealias Position = EndcapInterposeCollectionPosition<Base>
  
  @usableFromInline
  package typealias Interposition = InterpositionElement<Base>
  
  @usableFromInline
  package typealias Storage = PositionIndexStorage<Position>
  
  @usableFromInline
  package var storage: Storage
  
  @inlinable
  package init(storage: Storage) {
    self.storage = storage
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
  internal init(interposition: Interposition) {
    self.init(position: .interposition(interposition))
  }

  @inlinable
  internal init(interpositionBetween precedingIndex: Base, _ subsequentIndex: Base) {
    self.init(
      position: .interposition(
        Interposition(
          precedingElement: precedingIndex,
          subsequentElement: subsequentIndex
        )
      )
    )
  }

  @inlinable
  internal static var endIndex: Self {
    Self(storage: .endIndex)
  }
  
  @inlinable
  internal static var intro: Self {
    Self(position: .intro)
  }
  
  @inlinable
  internal static var outro: Self {
    Self(position: .outro)
  }
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - Comparable
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionIndex: Comparable {
  @inlinable
  public static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.storage < rhs.storage
  }
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionIndex: CustomStringConvertible {
  @inlinable
  public var description: String {
    String(describing: storage)
  }
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionIndex: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: type(of: self)))(storage: \(String(reflecting: storage)))"
  }
}

