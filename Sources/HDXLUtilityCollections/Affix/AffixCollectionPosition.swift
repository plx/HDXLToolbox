import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros
import HDXLCollectionSupport

@usableFromInline
@ConditionallySendable
@AlwaysEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyAutoIdentifiable
package enum AffixCollectionPosition<Base> where Base: Comparable {
  case prefix
  case base(Base)
  case suffix
}

extension AffixCollectionPosition: Comparable {
  
  @inlinable
  package static func < (
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
