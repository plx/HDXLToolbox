import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros

@usableFromInline
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
package enum InterjectionCollectionPosition<Base> where Base: Comparable {
  
  @usableFromInline
  package typealias Interjection = InterpositionElement<Base>
  
  case element(Base)
  case interjection(Interjection)
  
}

extension InterjectionCollectionPosition: Comparable {
  @inlinable
  package static func < (
    lhs: InterjectionCollectionPosition<Base>,
    rhs: InterjectionCollectionPosition<Base>
  ) -> Bool {
    switch (lhs, rhs) {
    case (.element(let lIndex), .element(let rIndex)):
      return lIndex < rIndex
    case (.element(let lIndex), .interjection(let rInterjection)):
      return lIndex <= rInterjection.precedingElement
    case (.interjection(let lInterjection), .element(let rIndex)):
      return lInterjection.subsequentElement <= rIndex
    case (.interjection(let lInterjection), .interjection(let rInterjection)):
      return lInterjection < rInterjection
    }
  }
}

extension InterjectionCollectionPosition: CustomStringConvertible {
  @inlinable
  package var description: String {
    switch self {
    case .element(let element):
      ".element(\(String(describing: element)))"
    case .interjection(let interjection):
      ".interjection(\(String(describing: interjection)))"
    }
  }
}

extension InterjectionCollectionPosition: CustomDebugStringConvertible {
  @inlinable
  package var debugDescription: String {
    switch self {
    case .element(let element):
      "\(String(reflecting: type(of: self))).element(\(String(reflecting: element)))"
    case .interjection(let interjection):
      "\(String(reflecting: type(of: self))).interjection(\(String(reflecting: interjection)))"
    }
  }
}
