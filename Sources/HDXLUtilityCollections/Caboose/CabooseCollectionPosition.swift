import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

@usableFromInline
@ConditionallySendable
@AlwaysEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyAutoIdentifiable
package enum CabooseCollectionPosition<Base> where Base: Comparable {
  
  case base(Base)
  case caboose
  
}

extension CabooseCollectionPosition: Comparable {
  
  @inlinable
  package static func < (
    lhs: CabooseCollectionPosition<Base>,
    rhs: CabooseCollectionPosition<Base>
  ) -> Bool {
    switch (lhs, rhs) {
    case (.base(let l), .base(let r)):
      l < r
    case (.base, .caboose):
      true
    case (.caboose, .base):
      false
    case (.caboose, .caboose):
      false
    }
  }
  
}

