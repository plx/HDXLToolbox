import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequenceElementType - Definition
// ------------------------------------------------------------------------- //

/// Case-enumeration for ``EndcapInterposeSequenceElement``.
@frozen
public enum EndcapInterposeSequenceElementType: UInt8 {
  case intro         = 0b00000001
  case element       = 0b00000010
  case interposition = 0b00000100
  case outro         = 0b00001000
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequenceElementType - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElementType: Sendable { }
extension EndcapInterposeSequenceElementType: Equatable { }
extension EndcapInterposeSequenceElementType: Hashable { }
extension EndcapInterposeSequenceElementType: Encodable { }
extension EndcapInterposeSequenceElementType: Decodable { }
extension EndcapInterposeSequenceElementType: CaseIterable { }
extension EndcapInterposeSequenceElementType: CustomStringConvertible { }
extension EndcapInterposeSequenceElementType: CustomDebugStringConvertible { }

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequenceElementType - Identifiable
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElementType: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequenceElementType - CaseNameAwareEnumeration
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElementType: CaseNameAwareEnumeration {
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .intro:
      "intro"
    case .element:
      "element"
    case .interposition:
      "interposition"
    case .outro:
      "outro"
    }
  }
}
