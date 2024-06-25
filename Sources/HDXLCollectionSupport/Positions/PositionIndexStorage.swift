import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// ------------------------------------------------------------------------- //
// MARK: PositionIndexStorage
// ------------------------------------------------------------------------- //

@usableFromInline
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyAutoIdentifiable
package enum PositionIndexStorage<Position> {
  
  case position(Position)
  case endIndex
 
  @inlinable
  package var position: Position? {
    switch self {
    case .position(let position):
      position
    case .endIndex:
      nil
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Comparable
// ------------------------------------------------------------------------- //

extension PositionIndexStorage: Comparable where Position: Comparable {
  
  @inlinable
  package static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    switch (lhs, rhs) {
    case (.position(let lPosition), .position(let rPosition)):
      lPosition < rPosition
    case (.position, .endIndex):
      true
    case (.endIndex, .position):
      false
    case (.endIndex, .endIndex):
      false
    }
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CaseIterable
// ------------------------------------------------------------------------- //

extension PositionIndexStorage: CaseIterable where Position: CaseIterable {

  @inlinable
  package static var allCases: [Self] {
    Position
      .allCases
      .map(Self.position(_:))
    
    + [.endIndex]
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension PositionIndexStorage: CustomStringConvertible {
  
  @inlinable
  package var description: String {
    switch self {
    case .position(let position):
      ".position(\(String(describing: position))"
    case .endIndex:
      ".endIndex"
    }
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension PositionIndexStorage: CustomDebugStringConvertible {
  
  @inlinable
  package var debugDescription: String {
    switch self {
    case .position(let position):
      "\(String(reflecting: Self.self)).position(\(String(reflecting: position)))"
    case .endIndex:
      "\(String(reflecting: Self.self)).endIndex"
    }
  }
  
}
