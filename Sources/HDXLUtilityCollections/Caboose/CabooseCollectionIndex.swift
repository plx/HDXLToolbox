import Foundation
import HDXLCollectionSupport

@frozen
public struct CabooseCollectionIndex<Base> where Base: Comparable {
  @usableFromInline
  internal typealias Position = CabooseCollectionPosition<Base>
  
  @usableFromInline
  internal var position: Position?

  @inlinable
  internal init() {
    self.position = nil
  }

  @inlinable
  internal init(_position position: Position) {
    self.position = position
  }

  @inlinable
  internal init(baseIndex: Base) {
    self.position = .base(baseIndex)
  }
  
  @usableFromInline
  internal static var caboose: CabooseCollectionIndex<Base> {
    CabooseCollectionIndex<Base>(_position: .caboose)
  }
  
  @usableFromInline
  internal static var endIndex: CabooseCollectionIndex<Base> {
    CabooseCollectionIndex<Base>()
  }
  
}

extension CabooseCollectionIndex: Sendable where Base: Sendable { }
extension CabooseCollectionIndex: Equatable { }
extension CabooseCollectionIndex: Hashable where Base: Hashable { }

extension CabooseCollectionIndex: Comparable {
  
  @inlinable
  public static func < (
    lhs: CabooseCollectionIndex<Base>,
    rhs: CabooseCollectionIndex<Base>
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
