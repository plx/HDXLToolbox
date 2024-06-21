import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: InterposeSequenceElementType - Definition
// ------------------------------------------------------------------------- //

/// Case-enumeration for ``InterposeSequenceElement``.
///
/// - seealso: ``InterposeSequenceElement``
///
@frozen
public enum InterposeSequenceElementType: UInt8 {
  
  /// Case corresponding-to ``InterposeSequenceElement.element(_)``.
  ///
  /// - seealso: ``InterposeSequenceElement.element(_)``
  case element
  
  /// Case corresponding-to ``InterposeSequenceElement.interposition(_)``.
  ///
  /// - seealso: ``InterposeSequenceElement.interposition(_)``
  case interposition
  
}

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension InterposeSequenceElementType: Sendable { }
extension InterposeSequenceElementType: Equatable { }
extension InterposeSequenceElementType: Hashable { }
extension InterposeSequenceElementType: CaseIterable { }
extension InterposeSequenceElementType: Codable { }
extension InterposeSequenceElementType: CustomStringConvertible { }
extension InterposeSequenceElementType: CustomDebugStringConvertible { }

// ------------------------------------------------------------------------- //
// MARK: - Identifiable
// ------------------------------------------------------------------------- //

extension InterposeSequenceElementType: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

// ------------------------------------------------------------------------- //
// MARK: - CaseNameAwareEnumeration
// ------------------------------------------------------------------------- //

extension InterposeSequenceElementType: CaseNameAwareEnumeration {
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .element:
      "element"
    case .interposition:
      "interposition"
    }
  }
}
