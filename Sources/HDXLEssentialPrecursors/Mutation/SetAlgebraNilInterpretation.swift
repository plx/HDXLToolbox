import Foundation

@frozen
public enum SetAlgebraNilInterpretation: UInt8 {
  case nothing
  case emptySet
}

extension SetAlgebraNilInterpretation: Sendable { }
extension SetAlgebraNilInterpretation: Equatable { }
extension SetAlgebraNilInterpretation: Hashable { }
extension SetAlgebraNilInterpretation: CaseIterable { }
extension SetAlgebraNilInterpretation: Codable { }

extension SetAlgebraNilInterpretation: CaseNameAwareEnumeration {
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    switch self {
    case .nothing:
      "nothing"
    case .emptySet:
      "emptySet"
    }
  }
}

extension SetAlgebraNilInterpretation: CustomStringConvertible { }
extension SetAlgebraNilInterpretation: CustomDebugStringConvertible { }

extension SetAlgebraNilInterpretation: Identifiable { 
  
  public typealias ID = Self
  @inlinable
  public var id: ID { self }
  
}
