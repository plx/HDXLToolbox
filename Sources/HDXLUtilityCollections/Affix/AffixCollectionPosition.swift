import Foundation
import HDXLEssentialPrecursors

@usableFromInline
internal enum AffixCollectionPosition<Base> where Base: Comparable {
  case prefix
  case base(Base)
  case suffix
}

extension AffixCollectionPosition: Sendable where Base: Sendable { }
extension AffixCollectionPosition: Equatable { }
extension AffixCollectionPosition: Hashable where Base: Hashable { }
extension AffixCollectionPosition: Encodable where Base: Encodable { }
extension AffixCollectionPosition: Decodable where Base: Decodable { }

extension AffixCollectionPosition: Comparable {
  @inlinable
  internal static func < (
    lhs: AffixCollectionPosition<Base>,
    rhs: AffixCollectionPosition<Base>
  ) -> Bool {
    switch (lhs, rhs) {
    case (.prefix, .prefix):
      false
    case (.prefix, .base):
      true
    case (.prefix, .suffix):
      true
    case (.base, .prefix):
      false
    case (.base (let l), .base(let r)):
      l < r
    case (.base, .suffix):
      true
    case (.suffix, .prefix):
      false
    case (.suffix, .base):
      false
    case (.suffix, .suffix):
      false
    }
  }
}


