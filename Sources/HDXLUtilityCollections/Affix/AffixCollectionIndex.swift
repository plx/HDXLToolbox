import Foundation
import HDXLEssentialPrecursors

@frozen
public struct AffixCollectionIndex<Base>: Comparable where Base: Comparable {
  @usableFromInline
  internal typealias Position = AffixCollectionPosition<Base>
  
  @usableFromInline
  internal var position: Position?
  
  @inlinable
  internal init(
    baseIndex: Base
  ) {
    self.init(
      position: .base(baseIndex)
    )
  }
  
  @inlinable
  internal init(position: Position) {
    self.position = position
  }
  
  @inlinable
  internal init(__unsafePosition position: Position?) {
    self.position = position
  }

  @inlinable
  internal static var prefix: Self {
    Self(position: .prefix)
  }

  @inlinable
  internal static var suffix: Self {
    Self(position: .suffix)
  }

  @inlinable
  internal static var endIndex: Self {
    Self(__unsafePosition: nil)
  }
  
  @inlinable
  public static func < (
    lhs: AffixCollectionIndex<Base>,
    rhs: AffixCollectionIndex<Base>
  ) -> Bool {
    switch (lhs.position, rhs.position) {
    case (.some(let l), .some(let r)):
      return l < r
    case (.some, .none):
      return true
    case (.none, .some):
      return false
    case (.none, .none):
      return false
    }
  }
}

extension AffixCollectionIndex: Sendable where Base: Sendable { }
extension AffixCollectionIndex: Hashable where Base: Hashable { }
extension AffixCollectionIndex: Codable where Base: Codable { }

