import Foundation

@frozen
public enum OrderingRelation: UInt8 {
  case equal              = 0b00000001
  case lessThan           = 0b00000010
  case lessThanOrEqual    = 0b00000100
  case greaterThan        = 0b00001000
  case greaterThanOrEqual = 0b00010000
}

extension OrderingRelation: Sendable { }
extension OrderingRelation: Equatable { }
extension OrderingRelation: Hashable { }
extension OrderingRelation: CaseIterable { }
extension OrderingRelation: Codable { }
extension OrderingRelation: CustomStringConvertible { }
extension OrderingRelation: CustomDebugStringConvertible { }

extension OrderingRelation: Identifiable { 
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

extension OrderingRelation: CaseNameAwareEnumeration {
  
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .equal:
      "equal"
    case .lessThan:
      "lessThan"
    case .lessThanOrEqual:
      "lessThanOrEqual"
    case .greaterThan:
      "greaterThan"
    case .greaterThanOrEqual:
      "greaterThanOrEqual"
    }
  }
}
