import Foundation

// TODO: supply a macro-based implementation of this
public protocol CaseNameAwareEnumeration {
  var caseNameWithoutLeadingDot: String { get }
}

extension CaseNameAwareEnumeration {
  @inlinable
  public var caseNameWithLeadingDot: String {
    ".\(caseNameWithoutLeadingDot)"
  }
}

extension CaseNameAwareEnumeration where Self: RawRepresentable, Self.RawValue == String {
  @inlinable
  public var caseNameWithoutLeadingDot: String {
    rawValue
  }
}

extension CaseNameAwareEnumeration where Self: CustomStringConvertible {
  @inlinable
  public var description: String {
    return caseNameWithLeadingDot
  }
}

extension CaseNameAwareEnumeration where Self: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    "\(type(of: Self.self))\(caseNameWithLeadingDot)"
  }
}

// need this redundant-looking overload to avoid ambiguity
// when making a `CodingKey` conform to `CaseNameAwareEnumeration`
extension CaseNameAwareEnumeration where Self: CodingKey {
  @inlinable
  public var description: String {
    caseNameWithLeadingDot
  }

  @inlinable
  public var debugDescription: String {
    "\(type(of: Self.self))\(caseNameWithLeadingDot)"
  }
}

