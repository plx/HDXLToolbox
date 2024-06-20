import Foundation

public protocol FlagOptionSet: OptionSet where Element == Self {
  static var allFlagOptions: [Self] { get }
  static var allFlagOptionsWithLeadingDotNames: [(Self, String)] { get }
}

extension FlagOptionSet {
  @inlinable
  public static var allFlagOptions: [Self] {
    allFlagOptionsWithLeadingDotNames.map { $0.0 }
  }
  
  @inlinable
  public static var allFlags: Self {
    Self(withUnionOf: allFlagOptions)
  }
}

extension FlagOptionSet where Self: Hashable {
  @inlinable
  public static var flagOptionSet: Set<Self> {
    Set(allFlagOptions)
  }
  
  @inlinable
  public static var flagOptionNames: [Self: String] {
    return [Self: String](uniqueKeysWithValues: allFlagOptionsWithLeadingDotNames)
  }
}

extension FlagOptionSet where Self: CustomStringConvertible {
  @inlinable
  public var description: String {
    let interior = Self.allFlagOptionsWithLeadingDotNames.localOnDemandCompactMap { (flag, nameWithLeadingDot) in
      switch contains(flag) {
      case true:
        return nameWithLeadingDot
      case false:
        return nil
      }
    }.joined(separator: ", ")
    return "[ \(interior) ]"
  }
}

extension FlagOptionSet where Self: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    let interior = Self.allFlagOptionsWithLeadingDotNames.localOnDemandCompactMap { (flag, nameWithLeadingDot) in
      switch contains(flag) {
      case true:
        return nameWithLeadingDot
      case false:
        return nil
      }
    }.joined(separator: ", ")
    return "\(String(reflecting: type(of: self)))([ \(interior) ])"
  }
}

extension FlagOptionSet {
  @inlinable
  public static var allFlagOptionCombinations: [Self] {
    var cases: [Self] = [Self()]
    for flag in Self.allFlagOptions {
      cases.append(contentsOf: cases.localOnDemandMap { $0.union(flag) })
    }
    return cases
  }
}

extension FlagOptionSet where Self: CaseIterable {
  
  @inlinable
  public static var allCases: [Self] { _allCases }
  
  @inlinable
  public static var _allCases: [Self] { allFlagOptionCombinations }
}

extension FlagOptionSet where Self: InversionCapableOptionSet {
  @inlinable
  public static var inversionReferenceValue: Self { _inversionReferenceValue }
  
  @inlinable
  public static var _inversionReferenceValue: Self { allFlags }
}
