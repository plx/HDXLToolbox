import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros

@usableFromInline
@ConditionallySendable
@AlwaysEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyEncodable
@ConditionallyDecodable
package enum EndcapInterposeCollectionPosition<Index> where Index: Comparable {
  @usableFromInline
  package typealias Interposition = InterpositionElement<Index>
  
  case intro
  case element(Index)
  case interposition(Interposition)
  case outro
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - Comparable
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionPosition: Comparable {
  @inlinable
  package static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    switch (lhs, rhs) {
    case (.intro, .intro):
      false
    case (.intro, .element):
      true
    case (.intro, .interposition):
      true
    case (.intro, .outro):
      true
    case (.element, .intro):
      false
    case (.element(let lIndex), .element(let rIndex)):
      lIndex < rIndex
    case (.element(let lIndex), .interposition(let rInterposition)):
      lIndex <= rInterposition.precedingElement
    case (.element, .outro):
      true
    case (.interposition, .intro):
      false
    case (.interposition(let lInterposition), .element(let rIndex)):
      lInterposition.subsequentElement <= rIndex
    case (.interposition(let lInterposition), .interposition(let rInterposition)):
      lInterposition < rInterposition
    case (.interposition, .outro):
      true
    case (.outro, .intro):
      false
    case (.outro, .element):
      false
    case (.outro, .interposition):
      false
    case (.outro, .outro):
      false
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionPosition: CustomStringConvertible {
  @inlinable
  public var description: String {
    switch self {
    case .intro:
      ".intro"
    case .element(let element):
      ".element(\(String(describing: element)))"
    case .interposition(let interposition):
      ".interposition(\(String(describing: interposition)))"
    case .outro:
      ".outro"
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeCollectionIndex - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeCollectionPosition: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    switch self {
    case .intro:
      "\(String(reflecting: type(of: self))).intro"
    case .element(let element):
      "\(String(reflecting: type(of: self))).element(\(String(reflecting: element)))"
    case .interposition(let interposition):
      "\(String(reflecting: type(of: self))).interposition(\(String(reflecting: interposition)))"
    case .outro:
      "\(String(reflecting: type(of: self))).outro"
    }
  }
}
