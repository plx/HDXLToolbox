import Foundation
import HDXLEssentialPrecursors

@usableFromInline
internal enum InterjectionCollectionPosition<Base> where Base: Comparable {
  
  @usableFromInline
  internal typealias Interjection = InterpositionElement<Base>
  
  case element(Base)
  case interjection(Interjection)
  
}

extension InterjectionCollectionPosition: Sendable where Base: Sendable { }
extension InterjectionCollectionPosition: Equatable { }
extension InterjectionCollectionPosition: Hashable where Base: Hashable { }
extension InterjectionCollectionPosition: Codable where Base: Codable { }

extension InterjectionCollectionPosition: Comparable {
  @inlinable
  internal static func < (
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
  internal var description: String {
    switch self {
    case .element(let element):
      return ".element(\(String(describing: element)))"
    case .interjection(let interjection):
      return ".interjection(\(String(describing: interjection)))"
    }
  }
}

extension InterjectionCollectionPosition: CustomDebugStringConvertible {
  @inlinable
  internal var debugDescription: String {
    switch self {
    case .element(let element):
      return "\(String(reflecting: type(of: self))).element(\(String(reflecting: element)))"
    case .interjection(let interjection):
      return "\(String(reflecting: type(of: self))).interjection(\(String(reflecting: interjection)))"
    }
  }
}
