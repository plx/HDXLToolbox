import Foundation

@usableFromInline
internal enum CabooseCollectionPosition<Base> where Base: Comparable {
  
  case base(Base)
  case caboose
  
}

extension CabooseCollectionPosition: Sendable where Base: Sendable { }
extension CabooseCollectionPosition: Equatable { }
extension CabooseCollectionPosition: Hashable where Base: Hashable { }

extension CabooseCollectionPosition: Comparable {
  
  @inlinable
  internal static func < (
    lhs: CabooseCollectionPosition<Base>,
    rhs: CabooseCollectionPosition<Base>
  ) -> Bool {
    switch (lhs, rhs) {
    case (.base(let l), .base(let r)):
      return l < r
    case (.base, .caboose):
      return true
    case (.caboose, .base):
      return false
    case (.caboose, .caboose):
      return false
    }
  }
  
}

