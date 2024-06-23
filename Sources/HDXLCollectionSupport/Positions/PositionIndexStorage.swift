import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: PositionIndexStorage
// ------------------------------------------------------------------------- //

@usableFromInline
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
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension PositionIndexStorage: Sendable where Position: Sendable {}
extension PositionIndexStorage: Equatable where Position: Equatable {}
extension PositionIndexStorage: Hashable where Position: Hashable {}
extension PositionIndexStorage: Encodable where Position: Encodable {}
extension PositionIndexStorage: Decodable where Position: Decodable {}

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
// MARK: - Identifiable
// ------------------------------------------------------------------------- //

extension PositionIndexStorage: Identifiable where Position: Identifiable {
  
  @usableFromInline
  package typealias ID = PositionIndexStorage<Position.ID>
  
  @inlinable
  package var id: ID {
    switch self {
    case .position(let position):
      .position(position.id)
    case .endIndex:
      .endIndex
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
