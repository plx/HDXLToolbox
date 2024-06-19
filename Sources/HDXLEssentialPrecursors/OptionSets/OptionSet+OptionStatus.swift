//
//  OptionSet+OptionStatus.swift
//

import Foundation

extension OptionSet {

  /// Returns `true` iff `self` "contains" `option`.
  ///
  /// *Intention* is for use when `Self` is a bitmask-style type and `option` is
  /// a single-bit "flag", but that scenario doesn't have a direct Swift representation.
  ///
  @inlinable
  public func optionStatus(for option: Self) -> Bool {
    return isSuperset(of: option)
  }
  
  /// Mutates `self` to either contain-or-*not*-contain `option`.
  ///
  /// *Intention* is for use when `Self` is a bitmask-style type and `option` is
  /// a single-bit "flag", but that scenario doesn't have a direct Swift representation.
  ///
  @inlinable
  mutating public func setOptionStatus(
    to status: Bool,
    for option: Self
  ) {
    switch status {
    case true:
      formUnion(option)
    case false:
      subtract(option)
    }
  }
  
}
