import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros

@usableFromInline
@ConditionallySendable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyAutoIdentifiable
package enum CabooseCollectionPosition<Base> where Base: Comparable {
  
  case base(Base)
  case caboose
  
}

extension CabooseCollectionPosition: Equatable { }

extension CabooseCollectionPosition: Comparable {
  
  @inlinable
  package static func < (
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

